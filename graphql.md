## 1. Introduction to GraphQL

graphql is a 'language' that api consumers can use to ask for data.

communication is hard. improving our communication skills makes our lives better on many levels.

graphql is a language and a runtime.
the client sends that text request to the api srvice through a transport channel (e.g. https). the graphql runtime layer accepts the text request, communicateds with other services ine backend stack to put together a suitable data response, then sends that data back to the consumer in a format like JSON.

an api is an interface that enables communication between multiple cmponents in an aplication.
e.g. an api can enable the communication that needs to happen between a web client and a db server. the client tellls the server what data it needs, and the server fulfills the clien's requirement wth objects representing the data the client asked for.

data api: api types that used to read and modify data.
other options include: REST, SOAP, XML, and SQL.

you need to use a service layer that supports graphql or implment one oourself.

JSON is a language that can be used to communicate data. the data comunicated does not have to use the same structure the database uses to seve it.

JSON is a popular language fr communicating data from api servers t client applications. most of the modern data api servers uses json t fulfill the data requirements of client applications. 

JSON can also be used by client applications to communicate their data requirements to api servers.
graphQL is another lang they can use to express their data requirements.

in a nutshell, graphql is all about optimizing data communication between client and server .
at the core of graphql is a string type system that is used to describe data and organize apis.

queries represent READ operations; mutations represent WRITE-then-READ operations. mutations as queries that have side effects.

a query language (graphql, sql) is different from programming language (python, javascript).

declarative thinking is easier for humans.

graphql is not a storage engine.
you need implement a translating runtime layer.

- 'structure' is defined with a storngly typed _schema_.

the schema is basically a graph of 'fields' 
'structure' is defined with a storngly typed _schema_.

- behavior is implemnnented with functions called resolver functions.

each field in a graphql schema is backed by a resolver function. it defines what data to fetch for its field.
for example, a resolver funciton might issue a sql statement to a relational database, reada file data directly from the operating system, update some cached data in a document database. graphql is essentially a way for clients to invoke remote resolver functions. remote procedure call.

a rest api is a colleciton of endpoints where each endpoint represents a resource. when a client needs data about multiple resources, it has to perform multiple network requests to that rest api and then put together the data by combinging the multiple responses it receives.

- a graphql schema contains fields that have types. this makes a graphql service predictable and discoverable.
- graphql makes the whole server a single smart endpoint that can reply to all data requests. web vs mobile.
- client request language solves the provlem of over-fetching data that is not needed.
- versioning can be avoided. the api just grows and no new endpoints are needed. mobile vs web.

scaling rest api: you add custom endpoints to efficiently satisfy clients' growing needs. managing custom endpoints is hard.

the graphql query is the exact structure of the json data object, except without all the 'value' parts.

if you have a graphql query, you know exactly how to use its response in the UI, because the query will have the same strucure as the response. you do not need to inspect the reponse to know how to use it, and you do not need any documentation about the api. it's all built-in.

'graphql will do to rest what json did to xml'.

Example:

Go to:

https://graphql.org/swapi-graphql/

Input:

https://jscomplete.com/learn/gia

```
{
  person(personID: 4) {
    name
    birthYear
    homeworld {
      name
    }
    filmConnection {
      films {
        title
      }
    }
  }
}
```

Output:

```
{
  "data": {
    "person": {
      "name": "Darth Vader",
      "birthYear": "41.9BBY",
      "homeworld": {
        "name": "Tatooine"
      },
      "filmConnection": {
        "films": [
          {
            "title": "A New Hope"
          },
          {
            "title": "The Empire Strikes Back"
          },
          {
            "title": "Return of the Jedi"
          },
          {
            "title": "Revenge of the Sith"
          }
        ]
      }
    }
  }
}
```

### Problems

#### security

resource-exhaustion attacks (aka denial-of-service attacks). deeply nested relationships or use field aliases to ask for the same field many times.
  * limits on the amount of data 
  * implement a timeout to kill requests
  * hanle rate-limit at a lower level under graphql
  * clients can ask server to execute preapproved queries using a unique query identfier.

graphql is a domain-specific language (dsl) ontop of your backend data-fetching logic. it's just one layer that you could put between the clients and your actual data services. authentication and authorization is another layer. if you want to put these layers behind graphql, you can use graphql to communicate the access tokens between the clients and the enforcing logic. this is similar to the way implemented in rest api.

#### Caching and optimizing

responses from rest apis are easier to cache because of their dictionary nature. a specific url gives certain data, so you can use the url itself as the cache key.

a graph query means a graph cache. if you normalize a graphql query respponse into a flat collectio nof records and give ach record a global unique id, you can cache those records instead of caching the full response.

N+1 SQL queries. graphql query fields are designed to be standalone functions, and resolving those fields with data from a database might result in a new database request per resolved field. facebook solution is DataLoader. is a utility you use to read data from databases and make it available to graphql resolvers. act as your agent to reduce the sql queries you send to the database. batching and caching.

construct optimal join-based sql queries by analyzing graphql requests.

- the best way to repsrent data in real world is with a graph data structure. a data model is a graph of related objects.
- a graphql system has 2 primary components: the query language, which can be used by consumers of data apis to request their exact data needs and the runtime layer on the backend, which publishes a public schema describing the capabilities and requirements of data models. the runtime layer accpets incoming requests on a single endpoint and resolves incoming data requests with predictable dta responses.


