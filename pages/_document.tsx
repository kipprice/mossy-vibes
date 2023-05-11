import { Head, Html, Main, NextScript } from "next/document";
import { PwaDetails } from "../components/shared/PwaDetails";

export const metadata = {
  title: "Create Next App",
  description: "Generated by create next app",
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
        <div className={`m-0 p-0 h-full w-full`}>
          <div className="left-0 top-0 fixed -z-10 w-full h-full bg-paper opacity-40" />
          <div className="bg-green-dark bg-opacity-80 w-full h-full text-off-white flex flex-col items-center">
            <div className="w-full h-full max-w-3xl">
              <Main />
              <NextScript />
            </div>
          </div>
        </div>
      </body>
    </Html>
  );
}
