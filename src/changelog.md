# Changelog

## v0.2.6

-   A `Route` now can have multiple `Guards`
-   Added Validation Layer after Gurads, with `Assertion` type
-   Add support for `Claims` type which can be used as Authorization medium in JWT, Basic etc..
-   Support added for `ExtensionBlock` which can be used as blocks which does not require server to
    run but perform operations depending upon server characteristic.

```bash
okrubik run --ext
```

runs the `ExtensionBlock`s attached to your server.

-   Host and Port both of them are required from the `config` directory
-   Cleanup unused and unwanted functions
-   Dependency injection is now developer-facing

## v0.2.0

-   Changes to Rubik’s Controller signature — Everything is a controller - [#32](https://github.com/rubikorg/rubik/pull/32)

```go
var r := rubik.Route{
	Path: “/”,
	Controller: indexCtl,
}

// === old method signature ===
// fund indexCtlOld(en interface{}) rubik.ByteResponse{
// 	return rubik.Success("Hello World")
// }

// === much cleaner and simple 0.2.0 method signature ===
func indexCtl(req *rubik.Request) {
	// rubik.Failure is now (req.Throw)
	req.Respond(“Hello World")
}
```

-   Now supports **interop** with Go's stdlib -- Any Handler || HandlerFunc can be casted to Controller

```go
var r := rubik.Route{
	Path: “/”,
	Controller: rubik.UseHandlerFunc(indexHandlerFunc), // OR UseHandler() for handlers
}

func indexHandlerFunc(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(&w, “Hello world")
}
```

-   `okrubik gen router ${name}` this command now parses ast properly and adds the new router import and its
    invocation
-   There is a new method call `NewProbe()` which helps you with testing rubik.Router(s)
-   CLI is now migrated to cobra instead of vanilla `flag.Parse()` for scalability reasons -
    [#5](https://github.com/rubikorg/okrubik/pull/5)
-   Improved API Documentation
