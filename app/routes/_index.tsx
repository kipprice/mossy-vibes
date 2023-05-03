import type { V2_MetaFunction } from "@remix-run/node";

export const meta: V2_MetaFunction = () => {
  return [{ title: "New Remix App" }];
};

export default function Index() {
  return (
    <div className="flex flex-col items-center justify-center h-full">
      <h1 className="text-3xl font-sans font-base">
        Welcome to Lexical Meditation
      </h1>
      <p>We're glad to see you here!</p>
      <button className="bg-Pine_green text-white px-8 py-2 rounded-full text-xl mt-4 hover:opacity-100 opacity-80 transition-opacity">
        Get Started
      </button>
    </div>
  );
}
