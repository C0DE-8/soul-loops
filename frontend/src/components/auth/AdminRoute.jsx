import { Navigate } from "react-router-dom";
import { jwtDecode } from "jwt-decode";

const AdminRoute = ({ children }) => {
  const token = localStorage.getItem("token");

  if (!token) {
    return <Navigate to="/login" replace />;
  }

  try {
    const decoded = jwtDecode(token);

    // Strict check for admin role
    if (decoded.role === "admin") {
      return children;
    }
    return <Navigate to="/dashboard" replace />;
  } catch (error) {
    // If token is invalid
    localStorage.clear();
    return <Navigate to="/login" replace />;
  }
};

export default AdminRoute;