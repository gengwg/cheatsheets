RL is not a replacement for SFT. it's next step. Most LLMs go through: Pre-training > SFT > RL for alignment.

Why you cannot skip SFT: it establishes the model quality baseline and provides the KL-divergence reference point for stable RL optimization.

- Pre-training: months, 1000s GPUs
- SFT: Hours to Days, 4-32 GPUs
- RF: Days to weeks, 32-129 GPUs

## Prefill and Decode

autoregressive: every new token is computed based on all proceeding tokens.
computing a new token requires calculating key, value and query vectors for each preceding token.
token generation cannot be parallelized at the level of an individual request.

for the very first output token, we start with empty KV cache and need calculate as many sets of key and value vectors as there are tokens in the input prompt.
any later token generation, all input tokens are known from beginning, we can parrallelize the calculation of their respective key and value vectors.

- prefill: computing the first output token
    - parallel processing of prompt tokens
    - compute intensive
    - time to first token
    - 3s or less
- decode: computing any later ouput token
    - sequential processing of single output tokens
    - memory-bound
    - time per output token
    - ideally 100-300ms per output token. at least reading speed.

non interactive use cases cares only totol token throuput, not individual request latencies.

tradeoff: maximizing total throughput vs minimizing latencies for each individual request.

chunked prefill maximize resource efficiency.
typical chunk sizes are 512-8192 tokens.
chunk size is a tuning knob for priorizing the time to first token or the time per output token.







