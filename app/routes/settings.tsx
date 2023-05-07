import React from 'react'
import { SettingsForm } from '../ui/Settings/SettingsForm'
import { LogFooter } from '../ui/shared/LogFooter'
import { PageHeader } from '../ui/shared/PageHeader'

export type SettingsPageProps = {}

export const loader = ({ params }: any) => {
  return {} as SettingsPageProps
}

export const SettingsPage: React.FC<SettingsPageProps> = () => {
  return (
    <div className="p-4">
      <PageHeader title="Your Settings" />
      <SettingsForm />
      <LogFooter />
    </div>
  )
}

export default SettingsPage
