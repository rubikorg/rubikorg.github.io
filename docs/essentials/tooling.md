# Tooling

## Commands

### create

Creates a new Rubik workspace and generates the boilerplate code for Rubik server.

Usage:
```bash
okrubik create
``` 

### gen

Generate _(gen)_ command generates components of Rubik server and binds them with the existing
components. There are currently 2 subcommands for this command:

1. `okrubik gen bin {name}` - This command generates a new binary/service/app inside your same
Rubik workspace. It is generated inside the `cmd` folder as a generic practise and also is 
accessible by commands such as `run`.

2. `okrubik gen router {name}` - This command generates a new router folder with the index route
right out of the box for you

### run

Run command runs your binary/service/app inside your Rubik workspace. It can access all the services
named and present inside `app` array inside rubik.toml file.

Some other functionalities are `watch` flag that let's run command watch for file changes inside 
the binary folder and then restart the server gracefully.

### help

Let's you see the available commands of the CLI.
