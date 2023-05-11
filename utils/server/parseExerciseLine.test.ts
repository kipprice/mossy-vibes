import { describe, it, expect } from 'vitest'
import { parseExerciseLine } from './parseExerciseLine'
import type { ParsedExercise } from '~/_types'

describe('parse exercise line', () => {
  it('can detect a header', () => {
    expect(parseExerciseLine('# Header', {} as ParsedExercise)).to.eql({
      title: 'Header',
    })
  })

  it('can detect an animation toggle', () => {
    expect(
      parseExerciseLine('', { prompts: [] } as any as ParsedExercise)
    ).to.eql({
      prompts: [{ content: '', toggleBreathAnimation: true }],
    })
  })

  it('can detect an animation toggle within whitespace', () => {
    expect(
      parseExerciseLine('   ', { prompts: [] } as any as ParsedExercise)
    ).to.eql({
      prompts: [{ content: '', toggleBreathAnimation: true }],
    })
  })

  it('can parse a line with a whole breath', () => {
    expect(
      parseExerciseLine('This is a full breath', {
        prompts: [],
      } as any as ParsedExercise)
    ).to.eql({
      prompts: [{ content: 'This is a full breath', minBreathParts: 3 }],
    })
  })

  it('can parse a line containing extra whitespace with a whole breath', () => {
    expect(
      parseExerciseLine('   This is a full breath ', {
        prompts: [],
      } as any as ParsedExercise)
    ).to.eql({
      prompts: [{ content: 'This is a full breath', minBreathParts: 3 }],
    })
  })

  it('can parse a line with evenly split breaths', () => {
    expect(
      parseExerciseLine('this / is / even', {
        prompts: [],
      } as any as ParsedExercise)
    ).to.eql({
      prompts: [
        { content: 'this', minBreathParts: 1 },
        { content: 'is', minBreathParts: 1 },
        { content: 'even', minBreathParts: 1 },
      ],
    })
  })

  it('can parse a line containing extra whitespace with evenly split breaths', () => {
    expect(
      parseExerciseLine('this    /  is /  even', {
        prompts: [],
      } as any as ParsedExercise)
    ).to.eql({
      prompts: [
        { content: 'this', minBreathParts: 1 },
        { content: 'is', minBreathParts: 1 },
        { content: 'even', minBreathParts: 1 },
      ],
    })
  })

  it('can parse a line containing an odd number of breaths', () => {
    expect(
      parseExerciseLine('this / is odd', {
        prompts: [],
      } as any as ParsedExercise)
    ).to.eql({
      prompts: [
        { content: 'this', minBreathParts: 1 },
        { content: 'is odd', minBreathParts: 2 },
      ],
    })
  })

  it('extends a last word to a full breath', () => {
    expect(
      parseExerciseLine('this / one / runs / long', {
        prompts: [],
      } as any as ParsedExercise)
    ).to.eql({
      prompts: [
        { content: 'this', minBreathParts: 1 },
        { content: 'one', minBreathParts: 1 },
        { content: 'runs', minBreathParts: 1 },
        { content: 'long', minBreathParts: 3 },
      ],
    })
  })
})
