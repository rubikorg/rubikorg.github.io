# 📓 Getting Started

Before you can use Rubik you need to make sure that development environment is up-to-date and ensure that everything is
setup correctly. Let's go throught the requirements of Rubik first.

## Install Go

Rubik Framework is written using Go programming language but you'll need Go runtime to execute your Rubik server. The
[official Go installation](https://golang.org/doc/install) guide provides you with a step by step instruction to install `Go`.

Testing your Go installation:

```bash
# this command outputs the version of Go runtime that you have installed
go version
```

## Installing okrubik

Rubik CLI helps you in being productive and accomplish your tasks with ease. It has some really nice advantages over
normal execution that is [discussed here](/blog/rubik-commands).

<span style="font-weight: bold">Shell</span>:

```bash
curl https://rubik.ashishshekar.com/install | sh
```

Thie CLI will be downloaded and installed under `$HOME/.rubik/bin` folder. You need to add this path to your
`bash_profile` or it's equivalents:

```bash
# example
nano ~/.bash_profile
# add the below line to the end of the file
export PATH="$HOME/.rubik/bin:$PATH"
```

Now let's check if the installation was successful. Run:

```bash
okrubik

# Welcome to Rubik Command-Line Manager use --help for help text
```

You have just set-up your development environment like a boss. You are ready to `Go!!`.

## Generating a New Rubik Project

In this tutorial you'll learn how to setup your Rubik project using the command-line generator and how easy
it is to setup a productive environment with Rubik.

In the previous tutorial we installed `okrubik` a CLI for this framework, to ensure that it is installed run:

```bash
okrubik help
```

which outputs the following help text for all the commands available in Rubik.

```
Rubik is an efficient web framework for Go that encapsulates
common tasks and functions and provides ease of REST API development.

Complete documentation is available at https://rubikorg.github.io

Usage:
  okrubik [flags]
  okrubik [command]

Available Commands:
  bundle      Create/Manage release bundle of your Rubik service
  exec        Execute a rubik command defined inside rubik.toml under [x] object
  gen         Generates project code for your Rubik server
  help        Help about any command
  new         Create a new Rubik project
  run         Runs the app created under this workspace
  upgrade     Upgrade the project dependencies or upgrade self

Flags:
  -h, --help   help for okrubik

Use "okrubik [command] --help" for more information about a command.
```

```bash
okrubik new helloworld
```

You'll have a new directory called `helloworld` now and will consists of Rubik project files.
Let's run the server by running:

```bash
okrubik run -a server
```

The `-a` flag accepts a name of the application in our case, the default `server` as the argument. If you have multiple server projects under the same workspace you can do `okrubik run` which shows a dynamic CLI selection of the list of your Rubik servers which we will take a look at in this [chapter](/chapter_4.md).

### Viewing server

Now let's visit [localhost:7000](http://localhost:7000). Wew! Our Rubik project is all set-up in just
under a minute. This is a great start!
