Notion has native Mermaid support to display your sequence diagram:

1. In a Notion page, type /code (or /mermaid on newer versions) and press Enter
2. Paste your diagram code:
sequenceDiagram
  participant GPUWorker
  participant KubernetesServices
  GPUWorker-->>ClusterScaleAgent: Return mounted or unmounted state
  RemountPlaybook->>KubernetesServices: Restart and verify services
4. Use the view toggle at the top of the block to switch between:
- Code — raw Mermaid source
- Preview — rendered diagram only
- Split — source on the left, live-rendered diagram on the right
