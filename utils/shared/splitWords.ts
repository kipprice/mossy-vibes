export const splitWords = (text: string) => {
  const words = text.split(/\s+/g);
  const out: string[] = [];

  words.forEach((w, wIdx) => {
    out.push(w);
    if (wIdx === words.length - 1) {
      return;
    }
    if (/[.;:!?]$/.exec(w)!!) {
      out.push("¶");
    }
  });

  return out;
};
