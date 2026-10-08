# Prompts

Prompts I paste into ChatGPT, Gemini, Claude or DeepSeek. Organized by task,
not by model, since most work anywhere.

## Explaining a codebase

Explain the codebase to a newcomer. What is the general structure, what are the
important things to know, and what are some pointers for things to learn next?

## Explaining a message, link or technology

```
In a nutshell, explain <Slack message, link or technology>
```

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

## Triaging Slack feedback into issues

Turn bug reports in a Slack feedback channel into GitLab issues without duplicates:

```
Create a GitLab issue for each bug report thread in <slack channel URL>.

- Go through the channel from newest to oldest, so recent reports are
  less likely to have an issue already.
- For each thread, search the project's existing issues for the same bug.
  - If one exists, skip it.
  - If not, create one that links to the Slack thread. Mimic existing bug
    reports in the project, including their labels (I think it is
    <label>, but double check).
- If several Slack threads report the same bug, create one issue and link
  the other threads to it.
- Confirm with me before creating each issue, so I can decide whether it
  deserves a ticket.
- Once the backlog is done, check the channel every 30 minutes and handle
  new reports the same way. Save state so you don't re-read old messages.
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
