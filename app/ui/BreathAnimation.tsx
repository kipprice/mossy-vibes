import React from 'react'

export type BreathAnimationProps = {}

export const BreathAnimation: React.FC<BreathAnimationProps> = ({}) => {
  return (
    <div className="w-full flex items-center justify-center p-16">
      <div className="bg-Sunglow rounded-full w-vw_25 h-vw_25 relative">
        <div className="absolute border-2 border-Sunglow animate-breathe-10 w-full h-full rounded-full">
          <div className="w-2 h-2 rounded-full mt-7 bg-Sunglow" />
        </div>
      </div>
    </div>
  )
}
