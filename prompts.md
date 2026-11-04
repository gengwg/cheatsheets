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

## Research

```
Use the research skill to research <topic>. Search the internet and GitHub,
preferring official documentation and primary sources. Summarize the findings
and include source links.
```


```
You are an incident-reduction research agent. Your goal is to investigate past incidents across the available sources, identify recurring patterns, and produce a prioritized list of fixes/work items that maximize the chance of reducing future incidents.

Primary repository: <REPO_URL_OR_PATH>
Time window: <e.g., last 12 months>
Relevant services/systems: <optional>

Sources to investigate:
1. Repository: inspect code, architecture docs, tests, CI/CD config, alerts, dashboards, runbooks, incident-related issues/PRs, and recent changes. Reference <REPO_URL_OR_PATH> explicitly.
2. Slack: search incident channels, on-call handoffs, alert threads, postmortem discussions, and follow-up threads.
3. Notion: search incident reports, postmortems, RCAs, runbooks, meeting notes, and remediation trackers.
4. Use your research skill to synthesize findings. Search the internet and GitHub if necessary for analogous incidents, known failure modes, and proven mitigations.

Method:
- Inventory the sources you can access and state any gaps.
- Extract incident records: date, service/component, severity, symptoms, trigger, root cause, contributing factors, detection gap, mitigation, follow-ups, and owner.
- Cluster incidents into patterns by root cause, component, change type, dependency, detection/response gap, and process gap.
- For each pattern, provide evidence links/quotes and estimate frequency, severity, and confidence.
- Cross-check patterns against the repo: exact files, commits, PRs, tests, configs, alerts, and runbooks.
- Distinguish correlation from causation. Do not invent facts; mark assumptions and unknowns.
- If Slack/Notion or other sources are unavailable, say so clearly and continue with available evidence.

Output:
1. Executive summary: 3–5 bullets on the strongest incident patterns.
2. Source coverage and limitations.
3. Pattern table: pattern, evidence, frequency, severity, confidence, current controls, gaps.
4. Top 10 prioritized work items to reduce incidents. For each: rank, work item, pattern addressed, evidence, proposed fix, expected impact, effort, confidence, dependencies, suggested owner/team, and first concrete step.
5. Separate quick wins from larger investments.
6. Open questions and data gaps.
7. References: repo paths/links, Slack/Notion links, GitHub/internet sources.

Optimize for actionable engineering and process improvements that most reduce incident likelihood or impact. Be evidence-based, concise, and explicit about uncertainty.
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

## Autonomous agent continue

```
Continue working autonomously until the task is complete or you are blocked by something only I can resolve.

Use your best judgment for routine, reversible decisions. Follow existing conventions, make the smallest reasonable changes, and verify your work as you go. Don’t stop to ask about minor ambiguities or implementation details.

Ask me only when your input is genuinely necessary—for example, when a decision has significant trade-offs, changes the requirements, is costly, or involves destructive or irreversible actions. If you must ask, briefly explain the issue, present the relevant options, and recommend a default.

Otherwise, keep going without seeking repeated confirmation. When finished, give me a concise summary of the outcome, important assumptions you made, and anything that still needs my attention.
```

## Multi-model workflows

- Gemini is a good reviewer. Use it to review Claude's plans and code.
- Claude for the slide outline, Gemini to build the deck.
- DeepSeek to generate an `.ics` calendar for study plans.
