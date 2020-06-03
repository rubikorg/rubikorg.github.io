+++
title = "Release Notes"
date = "2020-06-02"
author = "Ashish Shekar"
+++

## v0.2.0

- Changes to Rubik’s Controller signature — Everything is a controller - [#32](https://github.com/rubikorg/rubik/pull/32)

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

- Now supports **interop** with Go's stdlib -- Any Handler || HandlerFunc can be casted to Controller

```go
var r := rubik.Route{
	Path: “/”,
	Controller: rubik.UseHandlerFunc(indexHandlerFunc), // OR UseHandler() for handlers
}

func indexHandlerFunc(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(&w, “Hello world")
}
```

- `okrubik gen router ${name}` this command now parses ast properly and adds the new router import and its 
invocation 
- There is a new method call `NewProbe()` which helps you with testing rubik.Router(s)
- CLI is now migrated to cobra instead of vanilla `flag.Parse()` for scalability reasons - 
[#5](https://github.com/rubikorg/okrubik/pull/5)
- Improved API Documentation