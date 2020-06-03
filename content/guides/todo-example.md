+++
title = "Write your first Rubik app"
date = "2020-05-31"
author = "Ashish Shekar"
description = "In this guide you'll learn how to set-up a Rubik project and run the server"
+++

This tutorial is going to be a really exciting one because you'll interact with Rubik and it's ecosystem 
direactly.

So in the [last tutorial](/guides/create-project) we created a project called `helloworld` and we ran it
using the `okrubik` CLI. Using that project as a base we are not only going to create a TODO-App backend but
we are also going to analyze the whole structure of this Rubik app so let's fasten our seatbelts and `Go`.

## Project Structure

The file/directory structure of the initial Rubik app is shown below:

| File/Folder | Purpose |
|-------------|----------|
| `main.go` | The entrypoint of your Rubik server. This is where your config is loaded and server is started. |
| `config/` | The TOML configurations of your project is placed here. `decl.go` is the declaration of your config. |
| `routers/` | Routers hold group of routes. Routers are grouped by responsibilities/domains in rubik. |
| `routers/*/route.go` | This file handles the creation of router and addition of routes under this domain. |
| `routers/*/controller.go`  |   Corresponding controllers of all routes under this domain can be located here. |
| `routers/import.go` | This file contains `Import` function which is the entripoint of all Routers into Rubik. |
| `static/` | This folder contains all the files that you want to serve statically under `/static` prefix path. |
| `templates/` | This folder holds files used for redering template as response. |
| `storage/` | This folder all files that can be organized and stored using the `Storage` API of Rubik. |

## Generate a Router

We now know the purpose of each files inside this project, now let's create our `todo` router:
```bash
okrubik gen router -n todo
```
This will generate a folder inside `./routers/todo` and generate our route.go and controller.go file.
In Rubik, routers can be thought of as a subsystem having one purpose OR domain-driven. The purpose of our `todo`
router is to only interact with the TODO part of our application.

Let's navigate to `route.go` inside our todo folder that we just created. You'll see something like this:
```go
package todo

import (
	r "github.com/rubikorg/rubik"
)

// Router for /todo routes
var Router = r.Create("/todo")

var indexRoute = r.Route{
	Path:       "/",
	Controller: indexCtl,
}

func init() {
	Router.Add(indexRoute)
}
```

Let's break each line down and get to know it's meaning. Unlike any other frameworks out there Rubik tries
to be descriptive and easy to read. 

- We are declaring `indexRoute` as a type of `rubik.Route` 
- with `Path` pointing to the root of this router and
- `Controller` assigned as `indexCtl`.
- We then add this `indexRoute` to this `Router` using the `Add` method so that this route becomes a part of todo Router.

## Add a TODO

For persistance we are going to use a simple [SQLite]() module for Go and save our todo into a `.sqlite` file. Let's create
a new add route inside our `todo/route.go`.
```go
var addRoute = r.Route{
	Path:       "/add",
	Controller: addCtl,
}

func init() {
    Router.Add(indexRoute)
    // ADD This to route to our router
    Router.Add(addRoute)
}
```

Let's create our controller called `addCtl` inside our `todo/controller.go`.
```go
func addCtl(req *Request) {
    req.Respond("I am the add route for TODO app")
}
```

Now let's run our server by doing `okrubik run -a server` and going to [http;//localhost:4000/todo/add](http;//localhost:4000/todo/add). You'll see the reponse that you have returned using the `Respond()` method.