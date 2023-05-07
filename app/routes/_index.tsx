import type { V2_MetaFunction } from '@remix-run/node'
import { Splash } from '../ui/Splash'

export const meta: V2_MetaFunction = () => {
  return [{ title: 'Mossy Vibes' }]
}

export default function Index() {
  return <Splash />
}
