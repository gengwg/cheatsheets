
- use augmented text for recommendation.
- llm has common sense, reasoning.

- **A system prompt** that tells them what task they are performing and what tone they should use
- **A user prompt** -- the conversation starter that they should reply to

### What information is included in the API

Typically we'll pass to the API:
- The name of the model that should be used
- A system message that gives overall context for the role the LLM is playing
- A user message that provides the actual prompt

There are other parameters that can be used, including **temperature** which is typically between 0 and 1; higher for more random output; lower for more focused and deterministic.

```
deepseek_api_key = os.getenv('DEEPSEEK_API_KEY')

deepseek_via_openai_client = OpenAI(
    api_key=deepseek_api_key,
    base_url="https://api.deepseek.com"
)

system_message = "You are an assistant that is great at telling jokes"
user_prompt = "Tell a light-hearted joke for an audience of Data Scientists"

prompts = [
    {"role": "system", "content": system_message},
    {"role": "user", "content": user_prompt}
  ]

response = deepseek_via_openai_client.chat.completions.create(
    model="deepseek-chat",
    messages=prompts,
)

print(response.choices[0].message.content)
```

## Prompts

See [prompts.md](prompts.md).
