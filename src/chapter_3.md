# 💟 Compatibility with Go stdlib

If you have developed your applications using the `net/http` package and want to use Handlers as
Rubik's route controller, it can be easily migrated to [Controller]() type in Rubik using simple
conversion methods. The middlewares which are also generally [http.Handler]() or
[http.HandlerFunc]() types can be migrated as well.

## Converting http.Handler

To convert a http.Handler into rubik.Controller you can use `UseHandler()` which accepts a Handler
as an input and returns a Controller. It can be inlined during Route declaration like so.

```go
import (
    "net/http"
    r "github.com/rubikorg/rubik"
)

type MyHandler {}

func (MyHandler) ServeHTTP(req *http.Request, writer *http.ResponseWriter) {
    // your code
}

var myRoute = r.Route{
    Path: "/mypath",
    Controller: r.UseHandler(MyHandler{}),
}
```

## Converting http.HandlerFunc

To migrate/use your old http.HandlerFunc you can use `UseHandlerFunc()` which accepts a HandlerFunc
and returns Controller. It can also be inlined.

```go
import (
    "net/http"
    r "github.com/rubikorg/rubik"
)

func myHandlerFunc(req *http.Request, writer *http.ResponseWriter) {
    // your code
}

var myRoute = r.Route{
    Path: "/mypath",
    Controller: r.UseHandlerFunc(myHandlerFunc),
}
```

## Using `stdlib` Handlers

Middlewares in Rubik are just Controller type. Using the above two methods you can generally use
most of the Handler and HandlerFunc's designed for `stdlib` in your Rubik project but some
middlewares has made a design choice of using intermediate handler functions such as
[CORS](https://github.com/rs/cors) handler. To use such functions there is a helper method called
`UseIntermHandler()` which takes in `func(http.Handler) http.Handler` type and returns a Rubik
Controller.

Example:

```go
import (
    "github.com/rs/cors"
    r "github.com/rubikorg/rubik"
)

var c = cors.New(cors.Options{
    AllowedOrigins: []string{"http://foo.com", "http://foo.com:8080"},
    AllowCredentials: true,
    Debug: true,
})

var myRoute = r.Route{
    Path: "/mypath",
    Middlewares: r.Middleware{
        r.UseIntermHandler(c.Handler),
    },
    Controller: myCtl,
}
```
