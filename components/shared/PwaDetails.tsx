import React from "react";
import details from "../../public/manifest.json";

export type PwaDetailsProps = {};

export const PwaDetails: React.FC<PwaDetailsProps> = ({}) => {
  const getIconPath = (iconSize: 32 | 48 | 72 | 96 | 144 | 192) =>
    `/icons/mushroom-${iconSize}.png`;
  return (
    <>
      {/* title of the web app */}
      <meta name="application-name" content={details.name} />
      <meta name="apple-mobile-web-app-title" content={details.name} />
      <meta property="og:title" content={details.name} />
      <meta name="twitter:title" content={details.name} />
      <meta property="og:site_name" content={details.name} />

      {/* description */}
      <meta name="description" content={details.description} />
      <meta name="twitter:card" content={details.description} />
      <meta property="og:description" content={details.description} />
      <meta name="twitter:description" content={details.description} />

      {/* URL */}
      <meta property="og:url" content={details.full_url} />
      <meta name="twitter:url" content={details.full_url} />

      {/** bg color */}
      <meta name="msapplication-TileColor" content={details.background_color} />

      {/** theme color */}
      <meta name="theme-color" content={details.theme_color} />

      {/* icons */}
      <link rel="apple-touch-icon" href={getIconPath(192)} />
      <link rel="apple-touch-icon" sizes="192x192" href={getIconPath(192)} />

      <link rel="shortcut icon" href="/favicon.ico" />

      <meta
        name="twitter:image"
        content={`${details.full_url}${getIconPath(192)}`}
      />
      <meta
        property="og:image"
        content={`${details.full_url}${getIconPath(512)}`}
      />

      {/* static info */}
      <link rel="manifest" href="/manifest.json" />
      <meta name="apple-mobile-web-app-capable" content="yes" />
      <meta name="apple-mobile-web-app-status-bar-style" content="default" />
      <meta name="format-detection" content="telephone=no" />
      <meta name="mobile-web-app-capable" content="yes" />
      <meta name="msapplication-config" content="/icons/browserconfig.xml" />
      <meta name="msapplication-tap-highlight" content="no" />
      <meta property="og:type" content="website" />
    </>
  );
};
