# Create a Notes Server

In this tutorial we'll create new notes server app where we can save our notes inside our SQLite database and list them using Rubik framework.

## Generate a Router

We now know the purpose of each files inside this project, now let's create our `Note` router:

```bash
okrubik gen router -n notes
```

This will generate a folder inside `./routers/Note` and generate our route.go and controller.go file.
In Rubik, routers can be thought of as a subsystem having one purpose OR domain-driven. The purpose of our `note`
router is to only interact with the `Note` part of our application.

Let's navigate to `route.go` inside our `notes/` folder that we just created. You'll see something like this:

```go
package notes

import (
	r "github.com/rubikorg/rubik"
)

// Router for /notes routes
var Router = r.Create("/notes")

var indexRoute = r.Route{
	Path:       "/",
	Controller: indexCtl,
}

func init() {
	Router.Add(indexRoute)
}
```

Let's break each line down and get to know it's meaning. Unlike any other frameworks out there Rubik tries to be descriptive and easy to read.

-   We are declaring `indexRoute` as a type of `rubik.Route`
-   with `Path` pointing to the root of this router and
-   `Controller` assigned as `indexCtl`.
-   We then add this `indexRoute` to this `Router` using the `Add` method so that this route becomes a part of Note Router.

## Adding a Note

Create a `Note` struct before we use it in our `route.go` code.

```go
type Note struct {
	ID 			int
	Title 		string
	Body 		string
	IsFinished 	bool
}
```

Create a new "add" route inside our `notes/route.go`.

```go
var addRoute = r.Route{
	Path:       "/add",
	Entity: 	Note{}, // NOTICE -- this line
	Controller: addCtl,
}

func init() {
    Router.Add(indexRoute)
    // ADD This to route to our router
    Router.Add(addRoute)
}
```

Create our controller called `addCtl` inside our `notes/controller.go`.

```go
import r "github.com/rubikorg/rubik"

func addCtl(req *r.Request) {
    req.Respond("I am the add route for Note app")
}
```

Now let's run our server by doing `okrubik run -a server` and going to [http;//localhost:4000/notes/add](http;//localhost:4000/notes/add). You'll see the response that you have returned using the `Respond()` method.

For persistance we are going to use a simple [SQLite](https://www.sqlite.org/index.html) module for Go and save our Note into a `.db` file. Let's work on the saving the Note part which is much more interesting that setting up a Route. We need to initialize a database connection for saving our queries to the `.db` file. Navigate and open `main.go` file.

```go
package main

import (
	"database/sql" // ADD -- Core SQL driver module
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
	database, err := sql.Open("sqlite3", "../../rubik-notes.db")
	if err != nil {
		// because we can't save notes without db connection
		panic(err)
	}

	// ADD -- sql query to create our Note table inside sqlite
	createQ := "CREATE TABLE IF NOT EXISTS notes (id INTEGER PRIMARY KEY, title TEXT, body TEXT);"
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
Action mode. Navigate and open `controller.go` inside our Note router and go to `addCtl`.

```go
package notes

import (
	"database/sql"

	r "github.com/rubikorg/rubik"
)

func indexCtl(req *r.Request) {
	req.Respond("Hello, this is the Note router!")
}

func addCtl(req *r.Request) {
	// Get our global dependency
	db, _ := req.GetDep().(*sql.DB)
	// get our Note values from the api
	note, _ := req.Entity.(*Note)

	statement, _ := db.Prepare("INSERT INTO notes (title, body) VALUES (?, ?);")
	_, err := statement.Exec(note.Title, note.Body)
	if err != nil {
		req.Throw(500, err)
	}

	req.Respond("Saved!")
}
```

Now click on this [http://localhost:4000/notes/add?title=Hello&body=World](http://localhost:4000/notes/add?title=Hello&body=World) link to see "Saved!".

## Listing our Notes

The Rubik's "Entity" abstraction makes it easy to get the values from `query` directly to the `td` variable. Now
we get the list of all save Notes by creating a `/list` route.

-   notes/route.go

```go
var listRoute = r.Route{
	Path:       "/list",
	Controller: listCtl,
}
```

```go
Router.Add(listRoute)
```

-   notes/controller.go

```go
func listCtl(req *r.Request) {
	db, _ := req.GetDep().(*sql.DB)
	rows, err := db.Query("SELECT * FROM notes;")
	if err != nil {
		req.Throw(500, err)
		return
	}

	var notes []Note
	for rows.Next() {
		n := Note{}
		err := rows.Scan(&n.ID, &t.Title, &n.Body)
		if err != nil {
			req.Throw(500, err)
			return
		}

		notes = append(notes, n)
	}

	req.Respond(notes, r.Type.JSON)
}
```

This will help us view the Notes in `JSON` format and make us feel **awesome**. Go to
[http://localhost:4000/notes/list](http://localhost:4000/notes/list).

Easy right? Let's take a look at the commands that Rubik has in the next chapter.
