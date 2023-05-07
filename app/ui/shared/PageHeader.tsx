import { useNavigate } from '@remix-run/react'
import React from 'react'
import { Icon } from './Icon'

export type PageHeaderProps = { title: string }

export const PageHeader: React.FC<PageHeaderProps> = ({ title }) => {
  const navigate = useNavigate()
  return (
    <div className="bg-green-dark bg-opacity-60  p-4 absolute left-0 top-0 w-full flex justify-center">
      <div className="grid grid-cols-[2rem_1fr_2rem] justify-center w-full max-w-3xl px-4">
        <button
          onClick={() => navigate(-1)}
          className="rounded-lg hover:bg-off-white hover:bg-opacity-10 w-9 h-9 flex justify-center items-center"
        >
          <Icon
            iconFileName="right_arrow"
            className="text-off-white w-8 h-8 rotate-180"
          />
        </button>
        <h1 className="w-full text-2xl font-light text-center">{title}</h1>
        {/* <button
          onClick={() => navigate(`/settings`)}
          className="rounded-lg hover:bg-off-white hover:bg-opacity-10 w-9 h-9 flex justify-center items-center"
        >
          <Icon
            iconFileName="gear"
            className="text-off-white w-8 h-8 rotate-180"
          />
        </button> */}
      </div>
    </div>
  )
}
