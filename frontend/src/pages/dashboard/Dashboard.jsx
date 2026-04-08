import { useCallback, useEffect, useRef, useState } from "react";
import { useNavigate } from "react-router-dom";
import { toast } from "react-hot-toast";
import { fetchGameStatus, postGameAction } from "../../api/gameApi";
import styles from "./Dashboard.module.css";

function normalizeChoices(raw) {
  if (raw == null) return [];
  if (Array.isArray(raw)) return raw.map(String).filter(Boolean);
  if (typeof raw === "string") {
    try {
      const p = JSON.parse(raw);
      return Array.isArray(p) ? p.map(String).filter(Boolean) : [];
    } catch {
      return [raw];
    }
  }
  return [];
}

function playerToHud(player) {
  if (!player) return null;
  return {
    hp: Number(player.hp) || 0,
    max_hp: Number(player.max_hp) || 1,
    mp: Number(player.mp) || 0,
    max_mp: Number(player.max_mp) || 1,
    sp: Number(player.sp) || 0,
    max_sp: Number(player.max_sp) || 1,
    hunger: Number(player.hunger) || 0,
    level: Number(player.current_level) || 1,
    species: player.species || "Unknown",
  };
}

/** Full-bleed background with opacity crossfade when URL changes */
function CrossfadeBg({ url }) {
  const [current, setCurrent] = useState(url ?? null);
  const [visible, setVisible] = useState(true);
  const first = useRef(true);

  useEffect(() => {
    if (first.current) {
      first.current = false;
      setCurrent(url ?? null);
      setVisible(true);
      return;
    }
    setVisible(false);
    const t = setTimeout(() => {
      setCurrent(url ?? null);
      setVisible(true);
    }, 280);
    return () => clearTimeout(t);
  }, [url]);

  const hasBg = Boolean(current);
  return (
    <div
      className={`${styles.bgLayer} ${!hasBg ? styles.darkMistBg : ""}`}
      style={{
        backgroundImage: hasBg ? `url(${current})` : undefined,
        opacity: visible ? 1 : 0,
      }}
    />
  );
}

/** Sprite with Dark Mist fallback on missing URL or failed load */
function SpriteImage({ src, alt, breatheClass }) {
  const [failed, setFailed] = useState(false);
  const ok = Boolean(src) && !failed;

  return (
    <div className={styles.spriteFrame}>
      {ok ? (
        <img
          key={src}
          src={src}
          alt={alt}
          className={`${styles.spriteImg} ${breatheClass || styles.breathe}`}
          onError={() => setFailed(true)}
        />
      ) : (
        <div className={styles.mist} aria-hidden>
          <span className={styles.mistLabel}>Dark Mist</span>
        </div>
      )}
    </div>
  );
}

/** Center entity with fade when swapping */
function EntitySprite({ src, name }) {
  const [failed, setFailed] = useState(false);
  const ok = Boolean(src) && !failed;

  return (
    <div className={styles.spriteFrame}>
      {ok ? (
        <img
          key={src}
          src={src}
          alt={name || "Encounter"}
          className={`${styles.spriteImg} ${styles.breathe}`}
          onError={() => setFailed(true)}
        />
      ) : (
        <div className={styles.mist} aria-hidden>
          <span className={styles.mistLabel}>Dark Mist</span>
        </div>
      )}
    </div>
  );
}

const Dashboard = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  const [hud, setHud] = useState(null);
  const [visuals, setVisuals] = useState({
    background: null,
    user_vessel: null,
    entity: null,
  });
  const [enemyStats, setEnemyStats] = useState(null);
  const [narrative, setNarrative] = useState("");
  const [choices, setChoices] = useState([]);
  const [pending, setPending] = useState(false);
  const [milestoneNote, setMilestoneNote] = useState(null);

  const applyPayload = useCallback((data) => {
    if (data.player_state) {
      setHud(playerToHud(data.player_state));
    } else if (data.stats) {
      setHud(data.stats);
    }
    if (data.visuals) {
      setVisuals({
        background: data.visuals.background ?? null,
        user_vessel: data.visuals.user_vessel ?? null,
        entity: data.visuals.entity ?? null,
      });
    }
    if (data.enemy_stats !== undefined) {
      setEnemyStats(data.enemy_stats);
    }
    if (data.system_output != null) {
      setNarrative(String(data.system_output));
    }
    if (data.choices != null) {
      setChoices(normalizeChoices(data.choices));
    }
    if (Array.isArray(data.milestones_fired) && data.milestones_fired.length) {
      setMilestoneNote(
        data.milestones_fired.map((m) => m.code || m.content).filter(Boolean).join(" · ")
      );
      setTimeout(() => setMilestoneNote(null), 8000);
    }
  }, []);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        setLoading(true);
        const data = await fetchGameStatus();
        if (cancelled) return;
        applyPayload(data);
        setError(null);
      } catch (e) {
        if (!cancelled) {
          setError(e.response?.data?.error || e.message || "Failed to load game.");
          toast.error("Could not sync with the Soul Loop.");
        }
      } finally {
        if (!cancelled) setLoading(false);
      }
    })();
    return () => {
      cancelled = true;
    };
  }, [applyPayload]);

  const handleLogout = () => {
    localStorage.removeItem("token");
    toast.success("Logged out successfully");
    navigate("/login");
  };

  const sendAction = async (action) => {
    try {
      setPending(true);
      const data = await postGameAction(action);
      applyPayload(data);
    } catch (e) {
      toast.error(e.response?.data?.error || e.message || "Action failed.");
    } finally {
      setPending(false);
    }
  };

  if (loading) {
    return (
      <div className={styles.shell}>
        <p className={styles.loading}>Syncing with the labyrinth…</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className={styles.shell}>
        <p className={styles.error}>{error}</p>
        <button type="button" className={styles.logout} onClick={handleLogout}>
          Logout
        </button>
      </div>
    );
  }

  const hpPct = hud
    ? Math.min(100, Math.round((hud.hp / Math.max(1, hud.max_hp)) * 100))
    : 0;
  const spPct = hud
    ? Math.min(100, Math.round((hud.sp / Math.max(1, hud.max_sp)) * 100))
    : 0;
  const mpPct = hud
    ? Math.min(100, Math.round((hud.mp / Math.max(1, hud.max_mp)) * 100))
    : 0;
  const hungerPct = hud ? Math.min(100, Math.round(Number(hud.hunger) || 0)) : 0;

  const showEntity = Boolean(enemyStats);

  return (
    <div className={styles.shell}>
      <header className={styles.topBar}>
        <div className={styles.identity}>
          {hud ? (
            <>
              <span>Lv.{hud.level}</span> {hud.species}
            </>
          ) : (
            "Soul Loop"
          )}
        </div>
        <button type="button" className={styles.logout} onClick={handleLogout}>
          Logout
        </button>
      </header>

      {hud && (
        <div className={styles.statRow}>
          <div className={styles.stat}>
            <span className={styles.statLabel}>HP</span>
            <div className={styles.barTrack}>
              <div
                className={`${styles.barFill} ${styles.hp}`}
                style={{ width: `${hpPct}%` }}
              />
            </div>
          </div>
          <div className={styles.stat}>
            <span className={styles.statLabel}>SP</span>
            <div className={styles.barTrack}>
              <div
                className={`${styles.barFill} ${styles.sp}`}
                style={{ width: `${spPct}%` }}
              />
            </div>
          </div>
          <div className={styles.stat}>
            <span className={styles.statLabel}>MP</span>
            <div className={styles.barTrack}>
              <div
                className={`${styles.barFill} ${styles.mp}`}
                style={{ width: `${mpPct}%` }}
              />
            </div>
          </div>
          <div className={styles.stat}>
            <span className={styles.statLabel}>Hunger</span>
            <div className={styles.barTrack}>
              <div
                className={`${styles.barFill} ${styles.hunger}`}
                style={{ width: `${hungerPct}%` }}
              />
            </div>
          </div>
        </div>
      )}

      <div className={styles.stageArea}>
        <CrossfadeBg url={visuals.background} />

        <div className={styles.spriteStage}>
          <div className={styles.userSlot}>
            <SpriteImage
              src={visuals.user_vessel}
              alt="Your vessel"
              breatheClass={styles.breatheSlow}
            />
          </div>

          {showEntity && (
            <div className={styles.entitySlot}>
              <EntitySprite src={visuals.entity} name={enemyStats?.name} />
            </div>
          )}
        </div>
      </div>

      <div className={styles.bottomPanel}>
        {enemyStats && (
          <div className={styles.enemyTag}>
            ⚔ {enemyStats.name} · Lv.{enemyStats.level} · Rank {enemyStats.rank} · HP{" "}
            {enemyStats.hp}/{enemyStats.max_hp}
          </div>
        )}
        {milestoneNote && (
          <div className={styles.milestoneBanner}>✦ Story: {milestoneNote}</div>
        )}
        <div className={`${styles.narrative} ${styles.storyFlash}`} key={narrative.slice(0, 40)}>
          {narrative || "Await your next move…"}
        </div>
        <div className={styles.actions}>
          {choices.length === 0 && (
            <button
              type="button"
              className={styles.actionBtn}
              disabled={pending}
              onClick={() => sendAction("Search")}
            >
              Search the area
            </button>
          )}
          {choices.map((c, i) => (
            <button
              type="button"
              key={`${i}-${c.slice(0, 24)}`}
              className={styles.actionBtn}
              disabled={pending}
              onClick={() => sendAction(c)}
            >
              {c}
            </button>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
