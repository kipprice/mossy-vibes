import type { V2_MetaFunction } from '@remix-run/node'
import { useNavigate } from '@remix-run/react'

export const meta: V2_MetaFunction = () => {
  return [{ title: 'New Remix App' }]
}

export default function Index() {
  const navigate = useNavigate()

  return (
    <div className="flex flex-col items-center justify-center h-full px-4 py-8">
      {/* <img
        alt="The title logo for shh..."
        src="/img/logo.png"
        className="h-24"
      ></img> */}
      <div className="flex-grow" />
      <h1 className="text-5xl mb-8 font-light">
        Welcome to <span className="font-base">Shh...</span>
      </h1>
      <p>We're glad to see you here!</p>
      <button
        onClick={() => navigate('/exercises')}
        className="bg-green-dark text-off-white px-8 py-2 rounded-full text-xl mt-4 hover:opacity-100 opacity-80 transition-opacity"
      >
        Get Started
      </button>
      <div className="flex-grow" />
      <img
        alt="Mushrooms growing on a log"
        src="/img/log.png"
        className="max-w-full w-96"
      ></img>
    </div>
  )
}
