import type { PropsWithChildren } from 'react'
import React from 'react'

export type ButtonProps = PropsWithChildren & {
  onClick: () => void
}

export const Button: React.FC<ButtonProps> = ({ onClick, children }) => {
  return (
    <button
      className="bg-off-white text-green-dark text-2xl rounded-full py-4"
      onClick={onClick}
    >
      {children}
    </button>
  )
}
