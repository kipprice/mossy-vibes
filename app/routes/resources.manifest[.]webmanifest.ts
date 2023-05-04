import type { LoaderFunction } from '@remix-run/node'
import { json } from '@remix-run/node'

export let loader: LoaderFunction = async () => {
  return json(
    {
      short_name: 'Mossy Vibes',
      name: 'Mossy Vibes',
      start_url: '/',
      display: 'standalone',
      background_color: '#136F63',
      theme_color: '#ffd25a',
      shortcuts: [
        {
          name: 'Homepage',
          url: '/',
          icons: [
            {
              src: '/icons/mushroom-96.png',
              sizes: '96x96',
              type: 'image/png',
              purpose: 'any monochrome',
            },
          ],
        },
      ],
      icons: [
        {
          src: '/icons/mushroom-36.png',
          sizes: '36x36',
          type: 'image/png',
          density: '0.75',
        },
        {
          src: '/icons/mushroom-48.png',
          sizes: '48x48',
          type: 'image/png',
          density: '1.0',
        },
        {
          src: '/icons/mushroom-72.png',
          sizes: '72x72',
          type: 'image/png',
          density: '1.5',
        },
        {
          src: '/icons/mushroom-96.png',
          sizes: '96x96',
          type: 'image/png',
          density: '2.0',
        },
        {
          src: '/icons/mushroom-144.png',
          sizes: '144x144',
          type: 'image/png',
          density: '3.0',
        },
        {
          src: '/icons/mushroom-192.png',
          sizes: '192x192',
          type: 'image/png',
          density: '4.0',
        },
      ],
    },
    {
      headers: {
        'Cache-Control': 'public, max-age=600',
        'Content-Type': 'application/manifest+json',
      },
    }
  )
}
