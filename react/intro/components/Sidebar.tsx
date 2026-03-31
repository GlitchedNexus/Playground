interface SidebarProps {
  viewHandler: React.Dispatch<React.SetStateAction<string>>;
}

export default function Sidebar({ viewHandler }: SidebarProps) {
  return (
    <div>
      <ul>
        <li>
          <button onClick={() => viewHandler("Home")}>Home</button>
        </li>
        <li>
          <button onClick={() => viewHandler("Deliveries")}>Deliveries</button>
        </li>
        <li>
          <button onClick={() => viewHandler("Machines")}>Machines</button>
        </li>
      </ul>
    </div>
  );
}
