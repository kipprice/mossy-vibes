import React from 'react'

export type LogFooterProps = {}

export const LogFooter: React.FC<LogFooterProps> = ({}) => {
  return (
    <div className="absolute w-full top-[82vh] flex items-center justify-center left-0">
      <img
        src="/img/log.png"
        alt="log with mushrooms"
        className="h-[15vh] ml-8 opacity-70"
      />
    </div>
  )
}
