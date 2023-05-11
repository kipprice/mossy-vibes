import { describe, it, expect, vi } from 'vitest'
import { loadFile } from './loadFile'

describe('load exercise', () => {
  it('has a registered function', () => {
    expect(loadFile).to.be.ok
  })

  it('can load a file', async () => {
    const lines = await loadFile('_test')
    expect(lines).to.eql([
      '# Header',
      'First prompt',
      '',
      'Evenly / broken / up',
      'Oddly broken / up',
      '',
      'Ending line',
    ])
  })
})
