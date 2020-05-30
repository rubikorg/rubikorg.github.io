# Swagger Block
source: [ [/blocks/swagger/swagger.go](https://github.com/rubikorg/blocks/blob/master/swagger/swagger.go) ]

## Steps

- Add Swagger Information about your server into `config/default.toml` file:

```toml
[swagger]
title = "my rubik server"
description = "this is my awesome rubik server"
version = "1.0.1"
termsOfService = "http://www.apache.org/licenses/LICENSE-2.0.html"
```

- Add this to `main.go` of your rubik server

```go
import (
    _ "github.com/rubikorg/blocks/swagger"
)
```

- Go to `SERVER_URL/rubik/docs` - replace SERVER_URL with your rubik server Base URL.

## [Thats it!]()