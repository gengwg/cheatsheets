# Prompts

Prompts I paste into ChatGPT, Gemini, Claude or DeepSeek. Organized by task,
not by model, since most work anywhere.

## Explaining a codebase

Explain the codebase to a newcomer. What is the general structure, what are the
important things to know, and what are some pointers for things to learn next?

## Code review

In dsh web, to create a reusable review agent:

```
Add a new agent preset for code review
```

## Sanity checks

Quick prompts to compare models or check a new endpoint works.

```
How many words are there in your answer to this prompt?
```

```
In 3 sentences, describe the color Blue to someone who's never been able to see.
```

## Multi-model workflows

- Gemini is a good reviewer. Use it to review Claude's plans and code.
- Claude for the slide outline, Gemini to build the deck.
- DeepSeek to generate an `.ics` calendar for study plans.
