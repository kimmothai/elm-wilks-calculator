# Wilks score calculator

A simple tool made with Elm for calculating Wilks score for powerlifting.
https://en.wikipedia.org/wiki/Wilks_coefficient

## Features

- Calculate your Wilks score in metric units.
- Switch the calculation formula with just the press of a button.

## Lessons learned

- Need lots of effort in thinking about the structure before coding a single line.
  - There was quite a bit of thinking needed when figuring out the Model and the Update.
- The first compilation felt satisfying. "If it compiles, it probably works" was true again. The code did not work before everything was in place. Coming from Javascript, this was a very new way of doing things.
- Keep pushing the limits. I deliberately tried to avoid reformatting prematurely. Overall, I think it was for the best as no time was wasted in this.
- "Let ... in" can be used inside view definitions.

## To do

- [ ] Reformat the code to use more of Elm's features.
- [ ] Review the Model. There are some unused variables that either can be used in the future, or discarded now.
- [ ] Implement the UI using Elm-UI and not Bulma.
- [ ] Round the score with two decimals
