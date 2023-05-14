"use client"

import { motion } from 'framer-motion'
import React, { useState } from 'react'
import { Icon } from './Icon'
import { useNavigate } from '../../utils/client'
export type PageHeaderProps = { title: string }

export const PageHeader: React.FC<PageHeaderProps> = ({ title }) => {
  const [isSidebarVisible, setIsSidebarVisible] = useState(false)

  const navigate = useNavigate()
  return (
    <>
    <div className="bg-off-black bg-opacity-10  p-4 absolute left-0 top-0 w-full flex justify-center">
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
        <button
          onClick={() => setIsSidebarVisible(true)}
          className="rounded-lg hover:bg-off-white hover:bg-opacity-10 w-9 h-9 flex justify-center items-center"
        >
          <Icon
            iconFileName="option_lines"
            className="text-off-white w-8 h-8 rotate-180"
          />
        </button>
      </div>

      <motion.div
        className="w-full h-full fixed left-0 top-0 bg-off-black bg-opacity-50 z-30"
        initial={{ opacity: 0, pointerEvents: 'none' }}
        animate={{
          opacity: isSidebarVisible ? 1 : 0,
          pointerEvents: isSidebarVisible ? 'auto' : 'none',
        }}
        onClick={() => setIsSidebarVisible(false)}
      >
        <motion.div
          className="w-4/5 h-full absolute bg-green-dark p-4 flex flex-col gap-8"
          initial={{ left: '100%' }}
          animate={{ left: isSidebarVisible ? '20%' : '100%' }}
        >
          <button className={sidebarButtonClass} onClick={() => navigate('/')}>
            Home
          </button>

          <button
            className={sidebarButtonClass}
            onClick={() => navigate('/exercises')}
          >
            Exercises
          </button>

          <button
            className={sidebarButtonClass}
            onClick={() => navigate('/settings')}
          >
            Settings
          </button>
          <div className='h-12' />
          <button className={sidebarButtonClass} onClick={() => navigate('/about')}>
            About Mossy Vibes
          </button>
          <div className='flex-grow' />
          <div className='w-full flex flex-col gap-1'>
          <div className='text-center'>Want to help us keep Mossy Vibes going strong?</div>
          {/* <div className=''
          <a className={`${sidebarButtonClass} bg-green-light text-center text-off-black shadow-lg`} href='https://buymeacoffee.com/mossyvibes'>
            Share
          </a> */}
          <a className={`${sidebarButtonClass} bg-green-light text-center text-off-black shadow-lg`} href='https://buymeacoffee.com/mossyvibes'>
            Donate or Subscribe
          </a>
          </div>
          <div className='h-12' />
        </motion.div>
      </motion.div>
    </div>
    <div className='h-[68px] flex-shrink-0' />
    </>
  )
}

const sidebarButtonClass =
  'hover:bg-off-white hover:bg-opacity-30 w-full px-4 py-2 text-2xl transition-all rounded-lg'
