interface DashboardProps {
  view: string;
}

export default function Dashboard({ view }: DashboardProps) {
  return <div>{view}</div>;
}
