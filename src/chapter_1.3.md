# Rubik's Project Structure

So in the [last chapter](/chapter_1.2.html) we created a project called `helloworld` and we ran it
using the `okrubik` CLI.

Let's anylize the structure of this Rubik app so let's fasten our seatbelts and `Go`. The below table specifies the role of each files in this project.

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

## Tree Representation

```bash
├── README.md
├── cmd
│   └── server
│       ├── config
│       │   ├── decl.go
│       │   └── default.toml
│       ├── main.go
│       ├── routers
│       │   ├── import.go
│       │   └── index
│       │       ├── controller.go
│       │       └── route.go
│       ├── static
│       │   └── main.css
│       └── templates
│           └── index.html
├── go.mod
├── go.sum
└── rubik.toml
```
