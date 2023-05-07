import React from 'react'
import { BreathInput } from './BreathInput'
import { ReadingSpeedInput } from './ReadingSpeedInput'

export type SettingsFormProps = {}

export const SettingsForm: React.FC<SettingsFormProps> = ({}) => {
  return (
    <form className="pt-20 w-full" onSubmit={(e) => e.preventDefault()}>
      <ReadingSpeedInput />
      <div className="mt-8" />
      <BreathInput />
    </form>
  )
}
