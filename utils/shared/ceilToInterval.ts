export const ceilToInterval = (currentValue: number, interval: number) => {
  if (currentValue % interval) {
    return currentValue + (interval - (currentValue % interval))
  } else {
    return currentValue
  }
}
