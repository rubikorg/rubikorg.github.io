# Block `->` JWT Authentication

This extension block for Rubik is used to easily authenticate `rubik.Request` containing **[Json Web Token](https://jwt.io/introduction/)**.

## Usage

`import`

```go
_ "github.com/rubikorg/blocks/guard/jwt"
```

## Example:

```go

import (
	r "github.com/rubikorg/rubik"
	"github.com/dgrijalva/jwt-go" // used for coercing type
	jwtBlock "github.com/rubikorg/blocks/guard/jwt"
)

var myRoute = r.Route{
	Guards: []Controller{jwtBlock.HeaderJWTMiddleware},
	Path: "/getSomething",
	Controller: myController,
}

func myController(req *r.Request) {
	claims, _ := req.Claims.(jwt.MapClaims)
}

```

### Config

```toml
[jwt_auth]
secret = "my jwt secret"
cooke_http_only = false
cooke_http_only_error "your request requires it to come through HTTP"
cookie_key = "tok"
unauth_error = "this is acustom unauthorized error"
expiry_time = 3 # your token expires in 3 seconds
expiry_key = "exp" # which claim field inside JWT has the expiry time
```

### Create Token

```go
func CreateToken(claims jwt.MapClaims, expiry bool) (string, error)
```

Rubik comes with a pretty neat extension method to create a JWT token from the `jwt.MapClaims` that you provide, and errors when a signature could not be made from the secret provided in config.

> **Error Status**
>
> `401` - The controllers return Unauthorized when token is present but is not a valid token
>
> `403` - The controllers return Forbidden when there is no token for a JWT Block protected route

There are 3 types of Controllers available in this block:

### Cookie Authentication Controller

```go
func CookieJWTMiddleware(req *rubik.Request)
```

This middleware controller can be used inside the rubik.Route to authenticate JWT with default key as 'token' and can override with `cookie_key` config so this block will look for overriden key, instead of default one

### Header Authentication Controller

```go
func HeaderJWTMiddleware(req *rubik.Request)
```

This middlware controller can be used in rubik.Route to authenticate JWT from the header. It follows the `Bearer` standard where you pass `Bearer $TOKEN` as the authorization header. It does not have any override from the config.

### Error-Free Authentication Controller

```go
func ParseClaimsMiddleware(req *rubik.Request)
```

This middleware can be used when there is no need to throw any error to the client but want to parse the jwt.MapClaims and be available inside the `rubik.Request.Claims`.
