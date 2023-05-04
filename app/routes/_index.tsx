import type { V2_MetaFunction } from '@remix-run/node'
import { Splash } from '../ui/Splash'

export const meta: V2_MetaFunction = () => {
  return [{ title: 'New Remix App' }]
}

export default function Index() {
  return <Splash />
}
