# Configuration

Configuration is a living-breathing component of the Rubik server. It is very much a part of the
system as core itself. Configs are used to setup your system as well as the extensions. 

Blocks _(extensions)_ configuration also lives inside your code and Rubik exposes them to
external functionalities.

Internal uses such as `port` inside your `default.toml` let's Rubik know which port to run the 
server on.


## Loading Configuration

Loading a config and maintaining is all taken care of by Rubik internal system and it's config
manager. Project config is the global config that your project can use in any routes.

For example: You have a firebase key that you want in a route for accessing FCM maybe. 

- We define this common key inside `default.toml`:

```toml
[firebase]
secret = "tis-is-cigerette"
```

- With this `ProjectConfig` struct inside `config/decl.go`

```go
type FirebaseConfig struct {
	Secret string
}

type ProjectConfig struct {
	Firebase FirebaseConfig
}
```

- We load it in our `main.go` file:

```go
func main() {
	var conf config.ProjectConfig
	err := rubik.Load(&conf)
}
```

## Accessing Configuration

We can access our `ProjectConfig` from any controller by calling `r.GetConfig()`:

```go
import (
	r "github.com/rubikorg/rubik"
	cfg "{myModule}/cmd/server/config"
)

func firebaseMsgCtl(en interface{}) r.ByteResponse {
	conf := r.GetConfig().(cfg.ProjectConfig)
	// access key
	sendFCM(conf.Firebase.Secret, "my message is: lol")
	return r.Success("lol")
}
```
