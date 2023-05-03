import type { V2_MetaFunction } from "@remix-run/node";

export const meta: V2_MetaFunction = () => {
  return [{ title: "New Remix App" }];
};

export default function Index() {
  return (
    <div className="flex items-center justify-center h-full">
      <h1 className="text-3xl">Welcome to Lexical Meditation</h1>
    </div>
  );
}
