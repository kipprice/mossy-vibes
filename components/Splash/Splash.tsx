import React from 'react'
import { Button } from '../shared'
import Image from 'next/image'
import { useNavigate } from '../../utils/client'

export type SplashProps = {}

export const Splash: React.FC<SplashProps> = ({}) => {
  const navigate = useNavigate()

  return (
    <main className="flex flex-col items-center justify-center h-full px-4 py-8">
      <div className="flex-grow" />
      <h1 className="text-5xl mb-8 font-light text-center">
        Welcome to{' '}
        <span className="font-base whitespace-nowrap">Mossy Vibes</span>
      </h1>
      <div className="mb-4">Meditate amongst the mushrooms</div>
      <Button onClick={() => navigate('/exercises')}>
        <div className="flex items-center justify-center gap-4">
          <Image
            src="/img/green-champignon.png"
            alt="green-mushroom"
            className="w-8"
            width={192}
            height={192}
          />
          <span>Get Started</span>
        </div>
      </Button>
      <div className="flex-grow" />
      <Image
        alt="Mushrooms growing on a log"
        src="/img/log.png"
        className="max-w-full w-96"
        width={400}
        height={200}
      />
    </main>
  )
}
