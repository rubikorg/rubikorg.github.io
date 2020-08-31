# Block `->` Swagger

Swagger block let's you add documentation and to your Rubik REST APIs and serve as a tool for
people to know and interact with your server.

## Usage

Add this to `main.go` of your rubik server

```go
_ "github.com/rubikorg/blocks/swagger"
```

## Steps

-   Add Swagger Information about your server into `config/default.toml` file:

```toml
[swagger]
title = "my rubik server"
description = "this is my awesome rubik server"
version = "1.0.1"
termsOfService = "http://www.apache.org/licenses/LICENSE-2.0.html"
```

-   Go to `SERVER_URL/rubik/docs` - replace SERVER_URL with your rubik server Base URL.
