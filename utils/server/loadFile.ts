import fs from "fs/promises";
import path from "path";

export const exerciseFilenames = [
  "first-meditation",
  "mossy-overview",
  "breathing-practice",
  "love",
  "waking-up",
  "benefits-of-meditation",
  "gratitude",
  "self-care",
  "taking-a-moment",
  "what-is-mindfulness",
  "relaxation",
  "micro-presence",
];

export const loadFile = async (filename: string) => {
  const resp = await fetch(`${process.env.HOSTING_URL}/models/${filename}.md`);
  return (await resp.text()).split(/\n/g);
};

export const openFile = async (filename: string) => {
  const f = await fs.open(path.join(`models/exercises/${filename}.md`));
  const lines: string[] = [];
  for await (const ln of f.readLines()) {
    lines.push(ln);
  }
  await f.close();
  return lines;
};
