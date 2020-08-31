# Entity

Entity in Rubik specifies the requirements for your target route to function. Specifying your
requirements explicitely comes with a lot of advantages. Let's try to specify an entity.

```go
type MyEntity struct {
	Name string
}
```

`MyEntity` is a spcification of requirement of your API, which states that **_"my API requires
name inside query to function properly."_**

#### Example Route with Entity

```go
var myRoute = rubik.Route {
	Path: "/myPath",
	Entity: MyEntity,
	Controller: myController,
}

// definition of myController
func myController(req *rubik.Request) {
	entity, _ := req.Entity.(*MyEntity)
	req.Respond("You have entered name as: " + entity.Name)
}

// replace myRouter with Router of your choice
[myRouter].Add(myRoute)
```

Lets **cURL** it:

```bash
curl "http://localhost:$PORT/myPath?name=tom"
```

> **Response**

```
You have entered name as: tom
```
