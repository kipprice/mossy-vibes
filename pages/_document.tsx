import { Head, Html, Main, NextScript } from "next/document";
import { PwaDetails } from "../components/shared/PwaDetails";

export const metadata = {
  title: "Mossy Vibes",
  description: "Meditate among the mushrooms",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <Html lang="en" className="w-full h-full m-0 p-0">
      <Head>
        <PwaDetails />
      </Head>
      <body className={`m-0 p-0 h-full w-full`}>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
