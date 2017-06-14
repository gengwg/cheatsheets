Tips for Kibana (including Timelion) GUI query and Dashboard.

### Kibana

#### [from, to] inclusive
server_response:[400 TO 599]

#### {from, to} exclusive
received_size:{300 TO 400}

#### Boolean operators must be all CAPS.
```
AND, OR, +, -, NOT
“hello” AND “world”
“hello” OR “world”
NOT messageSize: 0
+: required operator: +jakarta lucene
-: prohibit operator: "jakarta apache" -"Apache Lucene"
Example: exceptionText : (+"rule" -"SQLLDR")
```
#### Use parentheses to group clauses to form sub queries.
(jakarta OR apache) AND website

#### Check the saved Dashboard, Visualizations.
Settings --> Objects

#### analyzed fields
Many fields in Kibana are not analyzed, which mean no matter how many words the fields contains, it is treated as a single one. For the analyzed fields, using `fieldName.raw` when using terms aggregation.

#### scale y axis metric by 1000.
Expand 'Advanced' --> Json Input:  
``{ "script": { "inline": "doc['response_time'].value/1000", "lang": "groovy" } }``

### Timelion

#### Example usage
.es(q="type:celery AND message:'Task send_batch'", kibana='False').lines().cusum().label("Emails Processed Today (in K) ").yaxis(label="# of Emails Processed (in K)").divide(5), .es(q="type:celery AND message:SUCCESS", kibana='False', offset='-1w').lines().cusum().label("Emails Processed Last Week (in K) ").yaxis(label="# of Emails Processed (in K)").divide(5),

#### show the "value" field as the y axis and "@timestamp" as the x aixs
`.es(metric='sum:value')`  
example:  
.es(type:hbasesgt metric='sum:sendCount').lines().cusum().movingaverage(window=50, position="left").divide(1000).yaxis(label="# of Emails (in K)").label("# Emails Scheduled Today (in K) ")
