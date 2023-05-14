import { Quicksand } from "next/font/google";
import "./globals.css";
import Head from "next/head";
import { NextPage } from "next";
import { AppProps } from "next/app";

export const App: NextPage<AppProps> = ({ Component, pageProps }) => {
  return (
    <>
      <Head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>Mossy Vibes</title>
      </Head>

      <div className={`m-0 p-0 h-full w-full`}>
        <div className="left-0 top-0 fixed -z-10 w-full h-full bg-paper opacity-40" />
        <div className="bg-green-dark w-full h-full  text-off-white flex flex-col items-center overflow-hiden">
          <div className="w-full h-full max-w-3xl overflow-hidden flex flex-col">
            <Component {...pageProps} />
          </div>
        </div>
      </div>
    </>
  );
};

export default App;
