# Cors Block
source: [ [/blocks/cors/cors.go](https://github.com/rubikorg/blocks/blob/master/cors/cors.go) ]

## Options

The JSON tags represents the configuration equivalents as shown [here](/blocks/cors/#steps).

```go
AllowedOrigins []string `json:"origins"`
AllowedMethods []string `json:"methods"`

AllowAllOrigins  bool `json:"allOrigins"`
AllowAllMethods  bool `json:"allMethods"`
AllowCredentials bool `json:"allowCredentials"`
```

## Steps

- Add your cors config to `default.toml` inside config directory

```go
[cors]
origins = [ "mywebsite.com" ]
allMethods = true
```

- Add this import to the `main.go` file

```go
import (
    _ "github.com/rubikorg/blocks/cors"
)
```

- Use cors middleware in your Routes

```go
import (
    "github.com/rubikorg/blocks/cors"
    r "github.com/rubikorg/rubik"
)

// git middeware from cors block
var corsMw = r.GetBlock(cors.BlockName).(cors.BlockCors).MW

var myRoute = r.Route{
    Path: "/",
    Middlewares: []r.Middleware{
        corsMw(), // like this
    },
}
```

## Overriding CORS

For A Specific Route you can override the global Cors Options just by passing your own cors options
to the middleware.

```go
import (
    "github.com/rubikorg/blocks/cors"
    r "github.com/rubikorg/rubik"
)

var corsMw = r.GetBlock(cors.BlockName).(cors.BlockCors).MW
var copts = cors.Options{
    AllowedOrigins: []string{"mynewwebsite.com"},
}

var myRoute = r.Route{
    Path: "/",
    Middlewares: []r.Middleware{
        corsMW(copts), // override like this
    },
}
```