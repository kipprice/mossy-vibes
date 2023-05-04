import type { SVGProps } from 'react'
import React from 'react'

export type IconProps = SVGProps<any> & {
  iconFileName: string
}

export const Icon: React.FC<IconProps> = ({ iconFileName, ...props }) => {
  return (
    <svg fill="transparent" {...props}>
      <use xlinkHref={`/svg/${iconFileName}.svg#main`} />
    </svg>
  )
}
