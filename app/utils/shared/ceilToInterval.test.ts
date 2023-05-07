import { describe, it, expect } from 'vitest'
import { ceilToInterval } from './ceilToInterval'

describe('ceil to interval', () => {
  it('does not make a change when the current value already is at the interval point', () => {
    expect(ceilToInterval(3, 3)).to.eq(3)
  })

  it('can adjust a number that would be rounded up to the next interval ', () => {
    expect(ceilToInterval(2, 3)).to.eq(3)
  })

  it('can adjust a number that would be rounded down to the next interval ', () => {
    expect(ceilToInterval(1, 3)).to.eq(3)
  })

  it('can reach a subsequent interval', () => {
    expect(ceilToInterval(4, 3)).to.eq(6)
  })
})
