# Generating a New Rubik Project

In this tutorial you'll learn how to setup your Rubik project using the command-line generator and how easy
it is to setup a productive environment with Rubik.

In the previous tutorial we installed `okrubik` a CLI for this framework, to ensure that it is installed run:
```bash
okrubik help
```

which outputs the following help text for all the commands available in Rubik.
```
# Rubik is an efficient web framework for Go that encapsulates
# common tasks and functions and provides ease of REST API development.

# Complete documentation is available at https://rubikorg.github.io

# Usage:
#   okrubik [flags]
#   okrubik [command]

# Available Commands:
#   create      Create a new rubik project
#   exec        Execute a rubik command defined inside rubik.toml under [x] object
#   gen         Generates project code for your Rubik server
#   help        Help about any command
#   run         Runs the app created under this workspace
#   upgrade     Upgrade the project dependencies or upgrade self

# Flags:
#   -h, --help   help for okrubik

# Use "okrubik [command] --help" for more information about a command.
```

You'll see the list and short description about Rubik commands. Let's create a `helloworld` 
Rubik project by running:

```bash
okrubik create
```

This will ask you questions such as `name`, `module-name`, `port` of the Rubik server and a 
confirmation like so:
```bash
# ? Project Name? **helloworld**
# ? Init go.mod with path? **helloworld**
# ? Default server port? **4000**
# ? Confirm? Yes
# creating helloworld/cmd/server/routers/import.go
# creating helloworld/cmd/server/routers/index/controller.go
# creating helloworld/cmd/server/routers/index/route.go
# creating helloworld/cmd/server/config/decl.go
# creating helloworld/cmd/server/config/default.toml
# creating helloworld/cmd/server/main.go
# creating helloworld/cmd/server/templates/index.html
# creating helloworld/README.md
# creating helloworld/rubik.toml
# creating helloworld/cmd/server/static/main.css
# creating go.mod
# tidying up |>  helloworld
# Done! Run command: okrubik run
```

You'll have a new directory called `helloworld` now and will consists of Rubik project files.
Let's run the server by running:
```bash
okrubik run -a server
```

The `-a` flag accepts a name of the application in our case, the default `server` as the argument. If you have multiple server projects under the same workspace you can do `okrubik server` which fires up a dynamic CLI selection of the list of your Rubik servers which we will take a look at in this [chapter](/chapter_4.md).

### Viewing server

Now let's visit [localhost:4000](http://localhost:4000). Wew! Our Rubik project is all set-up in just 
under a minute. This is a great start!