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

      <Component {...pageProps} />
    </>
  );
};

export default App;
