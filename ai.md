RL is not a replacement for SFT. it's next step. Most LLMs go through: Pre-training > SFT > RL for alignment.

Why you cannot skip SFT: it establishes the model quality baseline and provides the KL-divergence reference point for stable RL optimization.

- Pre-training: months, 1000s GPUs
- SFT: Hours to Days, 4-32 GPUs
- RF: Days to weeks, 32-129 GPUs
