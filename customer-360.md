## Customer 360

What it takes to give leadership one view of customers: revenue, renewals, concentration and risk. Prices are USD list prices as checked on 2026-10-07; annual billing is used where noted. Claims without a primary source are marked (unverified).

### Buy options

| Option | Price | Fit for a leadership portfolio view |
|---|---|---|
| [Attio](https://attio.com/pricing) | Free (3 reports), Plus $35, Pro $79 per seat/mo annual; Pro allows 100 reports | Good if ARR and renewal dates already live as CRM fields |
| [HubSpot Service Hub](https://www.hubspot.com/pricing/service) | Pro $90/seat/mo annual or $100 monthly + $1,500 onboarding; Enterprise $150 + $3,500 | Health scores need Pro or Enterprise ([KB](https://knowledge.hubspot.com/customer-success/use-the-customer-success-workspace)) |
| [Salesforce Sales Cloud](https://www.salesforce.com/sales/pricing/) | $25-550 per user/mo across suites/editions | Too heavy unless you already have it |
| [Gainsight](https://www.gainsight.com/pricing/), [Vitally](https://www.vitally.io/pricing), [Planhat](https://www.planhat.com/pricing) | Quote only | Built around CSM playbooks; exec dashboards exist, but you pay for the whole CS platform |
| [Metabase](https://www.metabase.com/pricing) | OSS free; Starter $100/mo (5 users); Pro $575/mo | Good value for read-only business dashboards |
| [Hex](https://hex.tech/pricing) | $36-75 per editor/mo | Better for analysis than a daily dashboard |
| [Grafana Cloud](https://grafana.com/pricing/) | Free (3 active users/mo); Pro $19/mo incl. 3 active users, then $8/active user | Fine via a Postgres datasource if you already run it |

### Minimal build

Connectors -> Postgres -> SQL/dbt models -> dashboard.

- Ingest: [dlt](https://dlthub.com/docs/dlt-ecosystem/destinations/), [Airbyte](https://airbyte.com/pricing) (cloud from $20/mo), or [Fivetran](https://www.fivetran.com/pricing) (free up to 500k MAR).
- Model: dbt Core is free; dbt Developer is free for 1 seat ([pricing](https://www.getdbt.com/pricing)).
- Freshness: `dbt source freshness` checks sources against configured warn/error thresholds ([docs](https://docs.getdbt.com/reference/commands/source)).

### Metrics

- NRR = (start MRR + expansion + reactivation - contraction - churn) / start MRR ([ChartMogul](https://chartmogul.com/saas-metrics/nrr/))
- GRR = (start MRR - contraction - churn) / start MRR, capped at 100% ([ChartMogul](https://chartmogul.com/saas-metrics/grr/))
- Definitions vary. Stripe counts upsells, cross-sells and expansion revenue in NRR ([Stripe](https://stripe.com/resources/more/net-revenue-retention-vs-gross-revenue-retention)), so write yours down once.
- Concentration (top-N share of ARR) and renewals pipeline (ARR renewing in the next 90/180 days) (unverified, common practice).

### Health score

A weighted roll-up of measures like usage, support and sentiment, mapped to a color or grade ([Gainsight](https://support.gainsight.com/gainsight_nxt/05Scorecards/01About/Scorecards_Overview)). Simple version: normalize 3-5 inputs to 0-100, weighted average, band into red/yellow/green. Keep it rule-based so anyone can see why an account is red.

### Failure modes

- Identity resolution: one account maps to different IDs in CRM, billing and product. Keep an explicit mapping table (unverified).
- Metric disputes: define metrics once in the model layer ([dbt Semantic Layer](https://docs.getdbt.com/docs/use-dbt-semantic-layer/dbt-sl) requires Starter or Enterprise).
- Stale data: alert on freshness.
- Nobody uses it: give it a named exec owner and use it in a recurring meeting (unverified).

### Decision guide

Few accounts and data already in the CRM: use CRM reports first. Data spread across systems: dlt -> Postgres -> dashboard. Buy a CS platform once you have a CS team running playbooks.
