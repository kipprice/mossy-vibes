import type { HTMLProps, PropsWithChildren } from 'react'
import React from 'react'

export type ButtonProps = PropsWithChildren &
  Pick<HTMLProps<HTMLDivElement>, 'className'> & {
    onClick: () => void
    variant?: 'light' | 'dark'
  }

export const Button: React.FC<ButtonProps> = ({
  onClick,
  children,
  variant = 'light',
  className,
}) => {
  return (
    <button
      className={`${
        variant === 'light' ? lightVariant : darkVariant
      } text-2xl rounded-full py-4 w-full px-8 hover:opacity-100 opacity-80 transition-opacity ${
        className || ''
      }`}
      onClick={onClick}
    >
      {children}
    </button>
  )
}

const darkVariant = 'bg-green-dark text-off-white'
const lightVariant = 'bg-off-white text-green-dark'
