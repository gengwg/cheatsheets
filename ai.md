RL is not a replacement for SFT. it's next step. Most LLMs go through: Pre-training > SFT > RL for alignment.

Why you cannot skip SFT: it establishes the model quality baseline and provides the KL-divergence reference point for stable RL optimization.

- Pre-training: months, 1000s GPUs
- SFT: Hours to Days, 4-32 GPUs
- RF: Days to weeks, 32-129 GPUs

Inference is final mile of AI ROI.

- KV Cache aware routing
- Prefill/Decode Disaagregation
- KV Cache offloading

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

A great video on PD segregation and more.

https://www.youtube.com/watch?v=MQR8jyTR5QE&list=PLj6h78yzYM2MLSW4tUDO2gs2pR5UpiD0C&index=36

balance of performance/pricing/ease of use.

## GQA/MLA/DSA

https://www.youtube.com/watch?v=Y-o545eYjXM

## Agent

AI agent is composed of a World Model that is fineptuned for a specific use-case. It can include other components to perceive information (sensors), build memory, or take actions.

two categories:

- Assistant (purpose is support)
- Characters (purpose is entertainment)

- Unified coordinated KV memory layer
  - UM makes pulling a KV segement from a remote node nearly indistinguishable from reading it directly from local GPU memory.
- Intelligent routing
  - gateway continuously tracks KV cache state for every engine in the cluster and estimates the prefill cost for each request on each node.
 
- Use cases: long-document retrieval, multi-turn conversations, agentic workflows 


## Metrics:
- TTFT
- E2E latency
- Throughput (tokens/sec)
- QPS (?)

## Glossary

- HAI: Human-AI intelligence
- MHA: Multi-head attention
- MQA: Multi-query attention
- GQA: Grouped-query attention
- MLA: Multi-head Latent Attention (DeepSeek V2)
- DSA: DeepSeek Sparse Attention (DeepSeek V3)

