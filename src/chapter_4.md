# ⌨️ Commanding your Workspace

Rubik comes with a lot of useful commands that makes web development easy in Go, in this chapter we are going to take a look at `okrubik` CLI's commands and how you can configure your workspace.

### Workspace Configuration

The configuration of your workspace in Rubik is done using the `rubik.toml` file. Let's take a look at the default Rubik configuration file.

```toml
name = "okrubik"
module = "github.com/rubikorg/okrubik"
flat = false
maxprocs = 0
log = false

[[app]]
  name = "server"
  path = "./cmd/server"
  watch = true
  communicate = false

[x]
  [x.test]
    command = "go test -cover ./cmd/server/..."
```

### `> create`

The `create` command is used to create a new Rubik project. It downloads all the boilerplate code required to get a barebones version of Rubik server running. It creates a new folder with the project name provided. There are 2 ways to run this command.

**Interactive Mode**

```bash
okrubik create
```

**Command Mode**

```bash
okrubik create -n helloworld -m helloworld -p 4000
```

### `> gen`

`gen` command generates components for your Rubik projects. Currently it can generate 2 things:

1. Binary

```bash
okrubik gen bin $binaryName
```

2. Router

```bash
okrubik gen router $routerName
```

### `> run`

**Interactive Mode**

```bash
okrubik run
```

**Command Mode**

```bash
okrubik run -a $appName
```

### `> exec`

The `exec` command runs your custom commands mentioned inside `rubik.toml`. As per our 1st topic, we can see this `x` object declaration.

```toml
[x]
  [x.test]
    command = "go test -cover ./cmd/server/..."
```

This block of configuration has a `[x.test]` which can be run inside your workspace. Let's try it out, and add a command called `foo` which just writes foo to stdout.

```toml
    [x.foo]
      command = "echo foo"
```

Now lets run this command using okrubik.

```bash
okrubik x foo

# foo
```

The `x` is an alias for `exec` and you can see it outputs `foo` as it runs the command that is declared inside `[x.foo]`.
