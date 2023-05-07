import type { PropsWithChildren } from 'react'
import React from 'react'

export type FormButtonProps = PropsWithChildren & {
  isSelected: boolean
  onClick: () => void
}

export const FormButton: React.FC<FormButtonProps> = ({
  isSelected,
  onClick,
  children,
}) => {
  return (
    <button
      onClick={onClick}
      className={`${buttonClass} ${
        isSelected ? 'bg-off-white bg-opacity-30' : ''
      }`}
    >
      {children}
    </button>
  )
}

const buttonClass =
  'hover:bg-off-white hover:bg-opacity-30 px-4 py-2 rounded-md'
