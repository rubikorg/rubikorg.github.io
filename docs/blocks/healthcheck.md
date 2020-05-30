# Health Check Block
source: [ [/blocks/healthcheck/health.go](https://github.com/rubikorg/blocks/blob/master/healthcheck/health.go) ]
## Steps

- Add this import to `main.go` file
```go
import (
	_ "github.com/rubikorg/blocks/healthcheck"
)
```

- [Optional] Add custom path for your health check through `config/default.toml`

```toml
[healthcheck]
path = "momos"
```

- [Done!]()