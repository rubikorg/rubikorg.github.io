# List of Available Blocks

Take a look at some blocks that the [@author](https://github.com/codekidX) has made until we get some more contributions:

- [Simple HTTPLogger Block](/blocks/httplogger) - A Rubik block for logging request path and response times.
<!-- - [Rubik Swagger Block](/blocks/swagger) - A customised swagger implementation that automatically generates Swagger docs of your Rubik routes. -->
- [HealthCheck Block](/blocks/healthcheck) - Readily appends a route for health check services like 
kubernetes etc..

# About Blocks

Components that are independant of the core system is called as a block. Blocks can never depend
on a specific nature of the server yet provide extended functionality to your Rubik server.

It can be seen as plugin system of Rubik ecosystem, but -- it has some features that tie it to 
the boot sequence of the Rubik's core thereby eventually making it part of the system.

## Writing a Block

Writing a block is as simple as implementing a singl method, thet serves as the `main` func for
your extension. A `struct` is considered as a Rubik Block only if you implement the `OnAttach` method
of the `rubik.Block` interface.

So what does it look like?

:: myawesomeblock.go
```go
package awesome

import (
	"fmt"
	r "github.com/rubikorg/rubik"
)

type BlockAwesome struct{}

func (a BlockAwesome) OnAttach(app *r.App) error {
	// block code
	fmt.Println("awesome block is initialized!")
	return nil
}
```

There are 2 things that catches the eye:

1. `app` parameter - The app parameter is supplied to you by rubik which gives you limited access
to the implementer's server. 

!!! Note
	This is not the Rubik instance itself, as this would be too big a vulnerability it supplies
	you with only the functions that you need to build a block.
2. `error` return statement - OnAttach is called first in the boot sequence by Rubik so if you
return an error the server will panic and not start, which is an intended workflow.

!!! Quote
	If the block can not even initialize properly, it can never function properly.

## Attaching a Block

A block can never be known by the Rubik server until you attach it, it can be done by calling
`rubik.Attach` inside the `init` method of this block file.

Considering the above example:

:: myawesomeblock.go
```go
package awesome

import (
	"fmt"
	r "github.com/rubikorg/rubik"
)

type BlockAwesome struct{}

func (a BlockAwesome) OnAttach(app *r.App) error {
	// block code
	fmt.Println("awesome block is initialized!")
	return nil
}

func init() {
	r.Attach("myawesomeblock", BlockAwesome{})
}
```

`rubik.Attach` takes in a `(name string, block rubik.Block)` as it's parameters.

## Best Practices

Notice how we had initialized the block? By passing a raw string -- this can prove dangerous while
developers using this block try to Get your Block for usage.

- It is is always a good practise to declare a `BlockName` constant inside your block file.
This can prove very useful while [getting the block]().
```go
// BlockName is this block's name -- like so
// and pass it inside the Attach method 
const BlockName = "myawesomeblock"
```
- Always Attach it inside the `init` method. Blocks are inherently separate components and is
designed in such a way too -- so why let developers Attach it separately inside their main file?


## Getting a Block

Developers can get your block while implementing their business logic from anywhere in the project.
Since Rubik is a singleton instance it maintaines a map of blocks by the name that you specify.

A very good example of this type of implementation is the [CORS](/blocks/cors) block:

```go
import (
    "github.com/rubikorg/blocks/yourBlock"
    r "github.com/rubikorg/rubik"
)

// notice how BlockName came in handy?
var yourBlock = r.GetBlock(yourBlock.BlockName)
```

`r.GetBlock()` gets the Block by name, rubik knows that it's a Block _(as it satisfies the Block
interface)_ but compiler just doesn't know which one _(yet ..generics please rant!!)_ ..

!!! Note
	There is no possible way that `r.GetBlock` returns any other Block because of the map and 
	unique key that it it maintains. So rest assured while coercing to your Block type.

## Accessible APIs by Blocks

### Decode
`type: Function`

Decode decodes the internal rubik server config into the struct that you provide. It returns
error if the config is not unmarshalable OR there if there is no config initialized by 
the given name parameter. It is useful when you really want some configs to be present for
your block to work.
```go
func (sb *App) Decode(name string, target interface{}) error {}
```
### Config
`type: Function`

Config gets config by name
```go
func (sb *App) Config(name string) interface{} {}
```

### CurrentURL
`type: String`

It is the localhost prepended current URL of your Rubik server.
```go
app.CurrentURL
```

### RouteTree
`type: Struct`
All The initialized Routes and their belongings such as `Entity`, `Description` etc.
```go
app.RouteTree
```

!!! Note
	A RouteTree is not initialized until boot sequence completes. If you want to make use of the
	RouteTree you can use `rubik.AttachAfter()` which attaches your Block after the boot sequence
	is complete.
