import { useState } from "react";
import Sidebar from "../components/Sidebar";
import Dashboard from "../components/Dashboard";
import "./App.css";

function App() {
  const [view, setView] = useState("Home");
  return (
    <>
      <h1>Big Ahh Header</h1>
      <section className="container">
        <Sidebar viewHandler={setView} />
        <Dashboard view={view} />
      </section>
    </>
  );
}

export default App;
