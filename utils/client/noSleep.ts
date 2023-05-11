import NoSleep from 'nosleep.js'

let noSleep: NoSleep

export const preventSleep = () => {
  if (!noSleep) {
    noSleep = new NoSleep()
  }
  noSleep.enable()
}

export const allowSleep = () => {
  if (!noSleep) {
    return
  }
  noSleep.disable()
}
