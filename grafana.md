shift + enter to run query.


## Notes

to design good dashboards, we must primarily understand people, not computers.

Every dashboard should have a goal or purpose.


Pillars of Observability:
- Metrics: WHAT went wrong
- Logs: WHY it went wrong
- Traces: WHERE it went wrong

- visual hiearchy: the visual properties of an object suggests how important it is.
- layout: we scan pages from top-down in a z-pattern
- size: bigger things are perceived more important
- colors: our eyes are drawn to bright saturated colors
- shapes: complexity is exciting
-

Everything in your dashboard should be *Important*.
but not all of it is equally important.

check grafana version:

```
➜  ~ curl -s https://grafana.aws.lambdalabs.cloud/api/health | jq
{
  "database": "ok",
  "version": "11.6.1",
  "commit": "ae23ead4d959aa73a5a0ffada60e4147d679523c"
}
```

## Resources

- [Getting started with Grafana dashboard design](https://watch.getcontrast.io/watch/grafana-labs-getting-started-with-grafana-dashboard-design-2)
