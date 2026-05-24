Refine my notes for Pytorch Conference 2024. separate them into sections when necesary. keep all URLs. Use bulletpoints when possible.


# Pytorch Conference 2024

Takeaways
Exciting times ahead for GenAl on edge Devices
﻿﻿Growing compute
﻿﻿Rapid pace of model innovation for the edge
PyTorch ecosystem is here to help, including:
﻿﻿Al Edge Generative APIhttps://github.com/google-ai-edge/ai-edge-torch
﻿﻿Visualize and Debug:https://github.com/google-ai-edge/model-explorer
﻿﻿Tune / Experiment with new models (not covered today but also great)https://github.com/pytorch/torchchathttps://github.com/pytorch/torchtune

LESSONS FOR THE BROADER PYTORCH COMMUNITY
﻿﻿Scientific machine learning has overlaps but differences with broader trends in machine learning
﻿﻿PyTorch + Linux Foundation great for stability.
﻿﻿Transformers are increasingly importantly for scientific applications.
﻿﻿Equation solving is critical. Linear equations, differential equations, non-linear equations.
﻿﻿Pretraining needs modular frameworks to support different loss functions.
﻿﻿Scientific machine learning is an early field yet. Most scientific codes are not yet differentiable.

For non-triton Python/C++/CUDA
Prefer writing operators over using raw kernels, especially if you're a library author.
Use torch.library.custom_op to wrap kernels into operators in Python
For triton kernels
• triton kernels work out-of-the-box with torch.compile. They're a hackable (and performant) alternative to CUDA kernels

* Choose Your Battles Wisely
Trainer "
Llama, Mistral, Mixtral, Pixtral, Gemma, Gemma 2, Qwen, Yi, Deepseek, DBRX, Mamba, Jamba, StarCoder, GPT, Command-R, etc
We can't troubleshoot everything.
Focus on subset of features that has the greatest impact for the most users.

Frameworks: PyTorch, SageMaker, Tense
Pylorch versions: 24 x, 23x, <22*
Model Types: CausalLM, Classifeston, ess
Fla
4, Secess

Dependencies & Cl
• Open communications channels
& Pin everything
﻿Automation to re-run Cl against main of primary upstream dependencies
﻿﻿Early signal of breaking changes upstreamCan even help to catch new bugs upstream


Basics of torchtune
﻿﻿Library of modular components
﻿﻿Training recipes
﻿﻿Full training loops meant for copying & modifying
﻿﻿Memory efficiency: single-device up to single-node

The FAST Compute Model
Futures: reference to objects (possible not created yet)
Actors: remote class instance (object)
Shared in-memory distributed object store
Tasks: remote functions

Ray classic API: weak support for GPUs
Trend: rapid transition CPU-centric → accelerator-centric world
Ray, very dynamic and flexible, but high overhead for small tasks
﻿﻿Pay the cost of RPC
﻿﻿Pay the cost of dynamic memory allocation
﻿﻿Difficult to efficiently support p2p protocols like RDMA or NCCL: require upfront resource allocation on all peers to avoid deadlock
﻿﻿Good for >10 ms tasks

accelerated Dynamic Acyclic Graphs (aDAGs)
Goals
﻿﻿Run tasks that are 1-10ms with < 1% system overhead
﻿﻿GPU-GPU data transfers with < 10us system overhead per op.
What are aDAGs?
Static task graphs with Ray Core-like API
﻿﻿Allocate resources once, reuse them for multiple executions
﻿﻿Declare p2p communication schedule before execution

Tight integration with PyTorch ecosystem
Most training and serving in Ray leverage PyTorch
Ray libraries used for scaling virtually any Al workload
aDAG will expand the workloads we support, e.g.
• Pipeline parallelism in vLLM (already integrated)
4D model parallelism

Summary
Al workloads are becoming more complex
Infrastructure is becoming more complex:
• Distributed, highly heterogeneous and clusters
Ray: compute framework to simplify scaling Al workloads
﻿﻿Tightly integrated with PyTorch ecosystem
﻿﻿Solution of choice for building next gen Al infrastructures

Pickles are unsafe
﻿﻿Load models from users you trust
﻿﻿Use weights _only=True
﻿﻿Scan pickle for viruses and imports
﻿﻿Use other serialization formats

Model-specific
Implementation-specific
Hardware-specific
Topology-specific

Often performance comes from control (fusions, memory allocations, offloading, comms overlap) for a specific model on specific hardware

How lim.c or llama.cpp got fast. Gave developers control without piercing through a thick stack.
Not because it's C, but because it's thin.

Thunder facilitates manipulating computations just in time, manually or automatically, keeping the stack thin.

MLP → Triton kernel → fusion transform (matmul + ReLU)

High Performance & Efficiency
• Optimized CUDA/Triton kernelsQuantized GeMM
→ Cutlass kernels
﻿﻿Grouped GeMM (e.g. MoE) → Triton kernels
﻿﻿All reduce
→ CUDA kernels
• Attention
→ Cutlass kernels
(FlashAttention, Formers)
• Others (e.g. RoPE)
→ CUDA or torch. compile
• CUDA graph to minimize host overheads

Runtime Generalization
Device Generalization
﻿﻿Categorize Devices: CPU and Accelerators
﻿﻿Accelerators: CUDA, HIP, XPU
﻿﻿Apply the concepts to Accelerator devices
﻿﻿Device
﻿﻿Stream/Queue
﻿﻿Event
﻿﻿Guard
﻿﻿Generator
﻿﻿Allocator


