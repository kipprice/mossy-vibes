import React from 'react'
import { LogFooter, PageHeader, SettingsForm } from '../components'


export const SettingsPage = () => {
  return (
    <>
      <PageHeader title="Your Settings" />
      <div className="w-full">
        <SettingsForm />
      </div>
      <LogFooter />
    </>
  )
}

export default SettingsPage
