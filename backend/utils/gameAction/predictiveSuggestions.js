const { fetchActivePlayerState, parsePermanentSkillNames, parseLibrarySkillsObject } = require('./fetchPlayerState');

const SYSTEM_LINE =
    'Based on these DB records, provide 3-5 short, valid auto-complete suggestions for the player\'s action.';

function parseInventoryJson(raw) {
    if (raw == null || raw === '') return [];
    try {
        const p = typeof raw === 'string' ? JSON.parse(raw) : raw;
        if (Array.isArray(p)) return p.map(String).filter(Boolean);
        if (p && typeof p === 'object') {
            return Object.entries(p).map(([k, v]) => `${k}${v != null && v !== '' ? `: ${v}` : ''}`);
        }
        return [];
    } catch {
        return [];
    }
}

/**
 * Keyword-scoped SQL / state snippets for Gemini.
 */
async function gatherDbHints(db, player, partial) {
    const hints = {
        location_connectors: null,
        skills: null,
        inventory_items: null
    };

    if (/\btravel\b/i.test(partial)) {
        const [rows] = await db.execute(
            `SELECT connector_id, from_location, to_location, direction, min_level_req
             FROM location_connectors
             WHERE from_location = ?`,
            [player.current_location]
        );
        hints.location_connectors = rows;
    }

    if (/\b(use|skill)\b/i.test(partial)) {
        const libMap = player.library_skills_map || parseLibrarySkillsObject(player.library_skills);
        hints.skills = {
            soul_library_skills: libMap,
            permanent_skills: parsePermanentSkillNames(player.permanent_skills)
        };
    }

    if (/\bitem\b/i.test(partial)) {
        hints.inventory_items = parseInventoryJson(player.inventory);
    }

    return hints;
}

function fallbackSuggestions(partial, hints, player) {
    const out = [];
    if (hints.location_connectors && hints.location_connectors.length) {
        for (const row of hints.location_connectors) {
            const dir = String(row.direction || '').replace(/_/g, ' ');
            const dest = String(row.to_location || '').replace(/_/g, ' ');
            out.push(`Travel ${dir} to ${dest}`);
            if (out.length >= 5) break;
        }
    }
    if (out.length < 3 && hints.skills) {
        const names = [
            ...Object.keys(hints.skills.soul_library_skills || {}),
            ...(hints.skills.permanent_skills || [])
        ];
        const uniq = [...new Set(names.map(String))];
        for (const n of uniq) {
            out.push(`Use ${n}`);
            if (out.length >= 5) break;
        }
    }
    if (out.length < 3 && hints.inventory_items && hints.inventory_items.length) {
        for (const it of hints.inventory_items) {
            out.push(`Use item ${it}`);
            if (out.length >= 5) break;
        }
    }
    if (out.length === 0) {
        out.push(`${partial.trim()}…`, `Explore ${String(player.current_location).replace(/_/g, ' ')}`);
    }
    return out.slice(0, 5);
}

function parseSuggestionsFromModelText(text) {
    const cleaned = String(text || '')
        .replace(/```json|```/gi, '')
        .trim();
    try {
        const arr = JSON.parse(cleaned);
        if (!Array.isArray(arr)) return null;
        const strings = arr.map((s) => String(s).trim()).filter(Boolean);
        return strings.length ? strings : null;
    } catch {
        const m = cleaned.match(/\[[\s\S]*\]/);
        if (!m) return null;
        try {
            const arr = JSON.parse(m[0]);
            if (!Array.isArray(arr)) return null;
            const strings = arr.map((s) => String(s).trim()).filter(Boolean);
            return strings.length ? strings : null;
        } catch {
            return null;
        }
    }
}

/**
 * @param {import('mysql2/promise').Pool} db
 * @param {*} model Gemini generative model
 * @param {number} userId
 * @param {string} partial
 * @returns {Promise<string[]>}
 */
async function buildPredictiveSuggestions(db, model, userId, partial) {
    const player = await fetchActivePlayerState(userId);
    const hints = await gatherDbHints(db, player, partial);

    const stateSummary = {
        current_location: player.current_location,
        current_level: player.current_level,
        species: player.species,
        vessel_type: player.vessel_type
    };

    const payload = {
        player: stateSummary,
        db_records: hints
    };

    const userPrompt = `${SYSTEM_LINE}

Partial player input: ${JSON.stringify(partial)}

Context (JSON):
${JSON.stringify(payload, null, 2)}

Respond with ONLY a JSON array of 3 to 5 strings (no markdown, no explanation), for example:
["Travel DOWN to Elroe Middle", "Travel RIGHT to Fungus Grotto"]`;

    try {
        const result = await model.generateContent(userPrompt);
        const text = result.response.text();
        const parsed = parseSuggestionsFromModelText(text);
        if (parsed && parsed.length > 0) {
            const merged = [...parsed];
            if (merged.length < 3) {
                const fb = fallbackSuggestions(partial, hints, player);
                for (const s of fb) {
                    if (merged.length >= 5) break;
                    if (!merged.some((x) => x.toLowerCase() === s.toLowerCase())) merged.push(s);
                }
            }
            return merged.slice(0, 5);
        }
    } catch (err) {
        console.error('PREDICTIVE_GEMINI_ERROR:', err.message);
    }

    return fallbackSuggestions(partial, hints, player);
}

module.exports = {
    buildPredictiveSuggestions,
    gatherDbHints,
    parseInventoryJson
};
