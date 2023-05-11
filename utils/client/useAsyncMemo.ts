import { useEffect, useRef, useState } from 'react'

export const useAsyncMemo = <T>(fn: () => Promise<T>, depArr: any[]) => {
  const fnHandle = useRef(fn)
  const [resp, setResp] = useState<T>()

  useEffect(() => {
    if (!fnHandle.current) {
      return
    }
    ;(async () => {
      const out = await fnHandle.current()
      setResp(out)
    })()
  }, [fnHandle, ...depArr])

  return resp
}
