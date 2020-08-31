# 🚔 Guards

Guards are rubik.Controller that "guards" your route from potentially bad/error-prone requests. As
you know that in Rubik every request is controlled/manipulated/processed by the
`rubik.Controller` type which you can read in [Section 4.5](./components/controllers.html).

There is no difference between a Middleware, Core request handler and Guards are nothing
different in case of function signature but the only difference is that, **_Guards run before
Assertions_**.

Let's say you want to reject any request that does not have the `x-rubik-client` header. Let's
write our guard.

#### Example Guard

```go
func rejectNonRubikClients(req *rubik.Request) {
	if (req.Raw.Header.Get("x-rubik-client") == "") {
		req.Throw(401, "You are not authorized to access this API.", rubik.Type.JSON)
		return
	}
}
```

Adding this guard to any of your route.

```go
var myRoute = rubik.Route{
	Guards: []Controller{rejectNonRubikClients},
	Path: "/getMeSomething",
	Controller: myCtl,
}
```

In this case `myRoute` will reject any client with:

```json
{
	"code": 401,
	"message": "You are not authorized to access this API."
}
```

for any request with `x-rubik-client` header being empty.
