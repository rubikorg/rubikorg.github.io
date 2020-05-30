# Rubik Test Suite

Rubik comes with it's own test suite to make it easier for developers to write tests.

In order to wite a test you take advantage of your Entity Abstraction.

```go
import (
    "yourpackage/routes"
    "yourpackage/entity"
    "github.com/okrubik/rubik"
)

func init() {
    var config map[string]interface{}
    routes.Import()
}

func TestOrderRoute(t *testing.T) {
    en := entity.OrderEntity{
        OrderId: 1,
    }
    req := rubik.Test.Mock()
    req.Header.Set("Authorization", "blahblah")
    resp, err := req.Test("/order", en)

    if !resp.Success {
        t.Errorf(resp.Message)
    }
}
```