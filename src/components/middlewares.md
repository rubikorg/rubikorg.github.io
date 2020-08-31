# Middlewares

In Rubik Middlewares are Controllers that run after your Assertions, meaning that they are just
Guards that postpone their executions until your Validations are done. Let's combine
[Guards: Section 4.1](./components/guards.html) example and add a middleware to get to know them better.

From [Guards: Section 4.1](./components/guards.html#example-guard) code we have this
`rubik.Controller`:

```go
func rejectNonRubikClients(req *rubik.Request) {
	if (req.Raw.Header.Get("x-rubik-client") == "") {
		req.Throw(401, "You are not authorized to access this API.", rubik.Type.JSON)
		return
	}
}
```

#### Example Middleware

```go
func checkAuthHeader(req *rubik.Request) {
	if (req.Raw.Header.Get("authorization") == "") {
		req.Throw(401, "Contact support!", rubik.Type.JSON)
		return
	}
}
```

Add it to the myRoute with validations:

```go
type MyEntity struct{
	Name string
}

var myRoute = rubik.Route{
	Path: "/getMeSomething"
	Entity: MyEntity{},
	Guards: []rubik.Controller{rejectNonRubikClients},
	Validation: rubik.Validation{
		"name": []rubik.Assertion{checker.StrIsOneOf("tom", "jerry")},
	},
	Middlewares: []rubik.Controller{checkAuthHeader},
}
// replace myRouter with Router of your choice
[myRouter].Add(myRoute)
```

Lets **cURL** it:

```bash
curl -H "authotization: Basic hi" "http://localhost:$PORT/getMeSomething?name=tom"
```

> **Response**

```json
{
	"code": 401,
	"message": "You are not authorized to access this API."
}
```

```bash
curl -H "x-rubik-client: clientToken" "http://localhost:$PORT/getMeSomething?name=tom"
```

> **Response**

```json
{
	"code": 401,
	"message": "Contact support!"
}
```
