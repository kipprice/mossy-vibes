import { describe, expect, it } from 'vitest'
import {
  getBreathCountFromType,
  getBreathTypeFromIdx,
  getExerciseCount,
  getPromptCount,
  getWpmCount,
  normalizeWpmCount,
} from './getCounts'
import {
  DEFAULT_BREATH_HOLD_IN_SECONDS,
  DEFAULT_BREATH_IN_IN_SECONDS,
  DEFAULT_BREATH_OUT_IN_SECONDS,
} from '../../_types'

describe('get Wpm Count', () => {
  it('can handle a single word', () => {
    expect(getWpmCount('word', 60)).to.eq(1)
  })

  it('can handle multiple words', () => {
    expect(getWpmCount('this is a short phrase', 60)).to.eq(5)
  })

  it('can handle punctuation without issue', () => {
    expect(getWpmCount('Sphinx of black quartz, judge my vow', 60)).to.eq(7)
  })
})

describe('normalize wpm count', () => {
  it('can handle a wpm count that is already within the min', () => {
    expect(normalizeWpmCount(4, 5, 1)).to.eql({
      length: 5,
      additionalBreathCounts: 0,
    })
  })

  it('can handle a wpm count that requires one extra breath count', () => {
    expect(normalizeWpmCount(5, 4, 1)).to.eql({
      length: 11,
      additionalBreathCounts: 1,
    })
  })

  it('can handle a wpm count that requires multiple extra breath count', () => {
    expect(normalizeWpmCount(21, 4, 1)).to.eql({
      length: 23,
      additionalBreathCounts: 3,
    })
  })
})

describe('get breath type from idx', () => {
  it('can get an in breath', () => {
    expect(getBreathTypeFromIdx(1)).to.eq('in')
  })
  it('can get an in breath from mod', () => {
    expect(getBreathTypeFromIdx(4)).to.eq('in')
  })
  it('can get a hold breath', () => {
    expect(getBreathTypeFromIdx(2)).to.eq('hold')
  })
  it('can get an out breath from mod', () => {
    expect(getBreathTypeFromIdx(5)).to.eq('hold')
  })
  it('can get an out breath', () => {
    expect(getBreathTypeFromIdx(3)).to.eq('out')
  })
  it('can get an out breath from mod', () => {
    expect(getBreathTypeFromIdx(6)).to.eq('out')
  })
})

describe('get breath count from type', () => {
  it('can use a default value for in breath', () => {
    expect(getBreathCountFromType('in')).to.eq(DEFAULT_BREATH_IN_IN_SECONDS)
  })
  it('can use a custom value for in breath', () => {
    expect(getBreathCountFromType('in', { inBreathInSeconds: 5 })).to.eq(5)
  })
  it('can use a default value for hold breath', () => {
    expect(getBreathCountFromType('hold')).to.eq(DEFAULT_BREATH_HOLD_IN_SECONDS)
  })
  it('can use a custom value for hold breath', () => {
    expect(getBreathCountFromType('hold', { holdBreathInSeconds: 5 })).to.eq(5)
  })
  it('can use a default value for out breath', () => {
    expect(getBreathCountFromType('out')).to.eq(DEFAULT_BREATH_OUT_IN_SECONDS)
  })
  it('can use a custom value for out breath', () => {
    expect(getBreathCountFromType('out', { outBreathInSeconds: 5 })).to.eq(5)
  })
})

describe('get prompt count', () => {
  it('can calculate a min count for a full prompt', () => {
    expect(
      getPromptCount({ content: 'This is a full line', minBreathParts: 3 }, 0, {
        readingSpeedInWpm: 60,
      })
    ).to.eql({ lengthInSeconds: 19, nextBreathIdx: 3 })
  })

  it('can calculate a min count for a single breath part', () => {
    expect(
      getPromptCount({ content: 'A test', minBreathParts: 1 }, 0, {
        readingSpeedInWpm: 60,
      })
    ).to.eql({ lengthInSeconds: 4, nextBreathIdx: 1 })
  })

  it('can resolve a longer prompt to read to the next breath part', () => {
    expect(
      getPromptCount(
        {
          content: 'This is too long for the specified breath',
          minBreathParts: 1,
        },
        0,
        {
          readingSpeedInWpm: 60,
        }
      )
    ).to.eql({
      lengthInSeconds: 11,
      nextBreathIdx: 2,
    })
  })

  it('can handle a non-breath-tied count', () => {
    expect(
      getPromptCount(
        { content: 'This is a full line', minBreathParts: 3 },
        -1,
        {
          readingSpeedInWpm: 60,
        }
      )
    ).to.eql({ lengthInSeconds: 7, nextBreathIdx: -1 })
  })
})

describe('get exercise count', () => {
  it('can calculate a simple non-breath based exercise', () => {
    expect(
      getExerciseCount(
        {
          id: 'test',
          title: 'Test',
          prompts: [
            { content: 'This is a short line', minBreathParts: 3 },
            {
              content:
                'This line is longer, but still fits within the breath cycle',
              minBreathParts: 3,
            },
          ],
        },
        { readingSpeedInWpm: 60 }
      )
    ).to.eq(20)
  })

  it('can calculate a simple breath based exercise', () => {
    expect(
      getExerciseCount(
        {
          id: 'test',
          title: 'Test',
          prompts: [
            { content: 'This is a short line', minBreathParts: 3 },
            { content: '', toggleBreathAnimation: true },
            {
              content:
                'This line is longer, but still fits within the breath cycle',
              minBreathParts: 3,
            },
            { content: '', toggleBreathAnimation: true },
            { content: 'This is the last line', minBreathParts: 3 },
          ],
        },
        { readingSpeedInWpm: 60 }
      )
    ).to.eq(33)
  })

  it('can calculate a more complex breath based exercise', () => {
    expect(
      getExerciseCount(
        {
          id: 'test',
          title: 'Test',
          prompts: [
            { content: 'This is a short line', minBreathParts: 3 },
            { content: '', toggleBreathAnimation: true },
            {
              content:
                'This line is longer, but still fits within the breath cycle',
              minBreathParts: 3,
            },
            {
              content: 'This is',
              minBreathParts: 1,
            },
            { content: 'an example', minBreathParts: 1 },
            { content: 'of a split line', minBreathParts: 1 },
            { content: '', toggleBreathAnimation: true },
            { content: 'This is the last line', minBreathParts: 3 },
          ],
        },
        { readingSpeedInWpm: 60 }
      )
    ).to.eq(52)
  })
})
