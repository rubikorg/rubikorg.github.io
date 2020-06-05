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

Create a TODO struct before we use it in our `route.go` code.
```go
type todo struct {
	ID 			int
	Title 		string
	Body 		string
	IsFinished 	bool
}
```

 Create a new "add" route inside our `todo/route.go`.
```go
var addRoute = r.Route{
	Path:       "/add",
	Entity: 	todo{}, // NOTICE -- this line
	Controller: addCtl,
}

func init() {
    Router.Add(indexRoute)
    // ADD This to route to our router
    Router.Add(addRoute)
}
```

Create our controller called `addCtl` inside our `todo/controller.go`.
```go
import r "github.com/rubikorg/rubik"

func addCtl(req *r.Request) {
    req.Respond("I am the add route for TODO app")
}
```

Now let's run our server by doing `okrubik run -a server` and going to [http;//localhost:4000/todo/add](http;//localhost:4000/todo/add). You'll see the reponse that you have returned using the `Respond()` method.

For persistance we are going to use a simple [SQLite](https://www.sqlite.org/index.html) module for Go and save our todo into a `.db` file. Let's work on the saving the TODO part which is much more interesting that setting up a Route. We need to initialize a database connection for saving our queries to the `.db` file. Navigate and open `main.go` file.

```go
package main

import (
	"database/sql" // ADD -- Core SQL module
	cfg "github.com/rubikorg/okrubik/cmd/server/config"

	"github.com/rubikorg/rubik"
	_ "github.com/mattn/go-sqlite3" // ADD -- import sqlite driver
)

func main() {
	var config cfg.ProjectConfig
	err := rubik.Load(&config)
	if err != nil {
		panic(err)
	}

	// ADD -- code to initialize our DB Connetion
	database, err := sql.Open("sqlite3", "../../rubik-todo.db")
	if err != nil {
		// because we can't save todo without db connection
		panic(err)
	}

	// ADD -- sql query to create our todo table inside sqlite
	createQ := "CREATE TABLE IF NOT EXISTS todo (id INTEGER PRIMARY KEY, title TEXT, body TEXT)"
	statement, _ := database.Prepare(createQ)
	statement.Exec()

	// ADD -- this line is used to set our global dependencies
	// Since we only have db connection as our dependency
	// we add it directly
	rubik.SetDep(database)

	routers.Import()

	panic(rubik.Run())
}
```

Great! we have setup a Database Connection to our SQLite database and we are now ready to go into
Action mode. Navigate and open `controller.go` inside our todo router and go to `addCtl`.

```go
package todo

import (
	"database/sql"

	r "github.com/rubikorg/rubik"
)

func indexCtl(req *r.Request) {
	req.Respond("Hello, this is the todo router!")
}

func addCtl(req *r.Request) {
	// Get our global dependency
	db, _ := req.GetDep().(*sql.DB)
	// get our todo values from the api
	td, _ := req.Entity.(*todo)

	statement, _ := db.Prepare("INSERT INTO todo (title, body) VALUES (?, ?)")
	_, err := statement.Exec(td.Title, td.Body)
	if err != nil {
		req.Throw(500, err)
	}

	req.Respond("Saved!")
}
```

Now click on this [http://localhost:4000/todo/add?title=Hello&body=World](http://localhost:4000/todo/add?title=Hello&body=World) link to see "Saved!".

The Rubik's "Entity" abstraction makes it easy to get the values from `query` directly to the `td` variable. Now
we get the list of all save TODOs by creating a `/list` route.

- todo/route.go

```go
var listRoute = r.Route{
	Path:       "/list",
	Controller: listCtl,
}
```

```go
Router.Add(listRoute)
```

- todo/controller.go

```go
func listCtl(req *r.Request) {
	db, _ := req.GetDep().(*sql.DB)
	rows, err := db.Query("SELECT * FROM todo")
	if err != nil {
		req.Throw(500, err)
		return
	}

	var todos []todo
	for rows.Next() {
		t := todo{}
		err := rows.Scan(&t.ID, &t.Title, &t.Body)
		if err != nil {
			req.Throw(500, err)
			return
		}

		todos = append(todos, t)
	}

	req.Respond(todos, r.Type.JSON)
}
```

This will help us view the TODOs in `JSON` format and make us feel **awesome**. Go to 
[http://localhost:4000/todo/list](http://localhost:4000/todo/list).

Easy right? Rubik is currently in alpha and do not have a lot of documentation or guides. If you
wanna help us put more guides or write for us please visit [Join Us Section](/guides/join-us).