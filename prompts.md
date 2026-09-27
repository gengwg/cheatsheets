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

## Debugging

With the superpowers plugin in Claude Code, to trigger its systematic-debugging skill:

```
use superpower debug mode to help me debug this slack message
```

## Long-running agent tasks

Paste above a task to keep the agent working until it is actually done:

```
use tmux with subagent registers to work on below task.
keep going until the task is genuinely finished, and all success criteria pass.
make sure not only tests pass, but also end to end works.
check slack or other connectors for latest info.
```

To split several independent tasks across parallel subagents:

```
use tmux with subagent registers to work on these 3 tasks below: ...
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
