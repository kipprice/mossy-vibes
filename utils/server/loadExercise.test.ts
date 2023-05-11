import { describe, it, expect, vi } from 'vitest'
import { loadExercise } from './loadExercise'

describe('load exercise', () => {
  it('has a registered function', () => {
    // eslint-disable-next-line @typescript-eslint/no-unused-expressions
    expect(loadExercise).to.be.ok
  })

  it('can get a title out of a particular document', async () => {
    const ex = await loadExercise('_test')
    expect(ex.title).to.eq('Header')
  })

  it('adds to the prompts', async () => {
    const ex = await loadExercise('_test')
    expect(ex.prompts).to.eql([
      { content: 'Prompt 1', minBreathParts: 3 },
      { content: 'Prompt 2', minBreathParts: 3 },
    ])
  })
})

vi.mock('./loadFile', async () => {
  return {
    loadFile: async () => ['# Header', 'Prompt 1', 'Prompt 2'],
  }
})
