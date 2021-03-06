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
- Bulma.css is a very nice tool and I might even prefer over Material-UI now.

## To do

- [ ] Reformat the code to use more of Elm's features.
- [ ] Review the Model. There are some unused variables that either can be used in the future, or discarded now.
- [ ] Implement the UI using Elm-UI and not Bulma.
- [x] Round the score with two decimals
- [ ] Figure out how to keep the Bulma.css and FontAwesome in index.html. They are lost after compiling.

## Vanishing Bulma and FontAwesome in index.html

```
<script
      defer
      src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.css"
    ></script>
<link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css"
    />
```
