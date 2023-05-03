import { useLoaderData } from '@remix-run/react'
import React from 'react'

export type SettingsPageProps = {}

export const loader = ({ params }: any) => {
  return {} as SettingsPageProps
}

export const SettingsPage: React.FC<SettingsPageProps> = () => {
  const {} = useLoaderData()
  return (
    <form>
      <label className="text-sm">What reading speed do you prefer?</label>
      <div className="flex flex-row mt-2 gap-2 text-lg">
        <input type="number"></input>
        <span>words per minute</span>
      </div>
      {/* TODO: allow for an automatic test */}
    </form>
  )
}

export default SettingsPage
