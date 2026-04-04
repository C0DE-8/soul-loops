import { useNavigate } from "react-router-dom";
import { toast } from "react-hot-toast";
import styles from "./Dashboard.module.css";

const Dashboard = () => {
  const navigate = useNavigate();

  const handleLogout = () => {
    localStorage.removeItem("token");
    toast.success("Logged out successfully");
    navigate("/login");
  };

  return (
    <div className={styles.dashboardContainer}>
      <div className={styles.card}>
        <h1 className={styles.title}>Dashboard</h1>
        <p className={styles.text}>Welcome to your dashboard.</p>

        <button className={styles.button} onClick={handleLogout}>
          Logout
        </button>
      </div>
    </div>
  );
};

export default Dashboard;