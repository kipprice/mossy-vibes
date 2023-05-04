import type { LinksFunction } from '@remix-run/node'
import {
  Links,
  LiveReload,
  Meta,
  Outlet,
  Scripts,
  ScrollRestoration,
} from '@remix-run/react'
import stylesheet from '~/tailwind.css'
import { useSWEffect } from '~/utils/client/sw-hook'
export const links: LinksFunction = () => [
  { rel: 'stylesheet', href: stylesheet },
]
export default function App() {
  useSWEffect()
  return (
    <html lang="en" className="h-full w-full p-0 m-0">
      <head>
        <meta charSet="utf-8" />
        <meta name="viewport" content="width=device-width,initial-scale=1" />
        <title>Shh...</title>
        <Meta />
        <link rel="manifest" href="/resources/manifest.webmanifest" />
        <Links />
      </head>
      <body className="h-full w-full p-0 m-0">
        <div className="left-0 top-0 fixed -z-10 w-screen h-screen bg-paper opacity-40" />
        <div className="bg-green-dark bg-opacity-80 w-full h-full text-white">
          <Outlet />
        </div>
        <ScrollRestoration />
        <Scripts />
        <LiveReload />
      </body>
    </html>
  )
}
