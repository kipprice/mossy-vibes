import { LogFooter, PageHeader } from "../shared"
import { SettingsForm } from "./SettingsForm"

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