+++
title = "Getting Started"
date = "2020-06-02"
author = "Ashish Shekar"
description = "This guide will help you set-up your environment for Rubik Development and download `okrubik` CLI."
+++

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

## Installing Rubik CLI

Rubik CLI helps you in being productive and accomplish your tasks with ease. It has some really nice advantages over
normal execution that is [discussed here](/blog/rubik-commands).

<span style="font-weight: bold">Shell</span>:
```bash
curl https://rubik.ashishshekar.com/install | sh
```

>   **Note**:
    okrubik is not supported for **Windows** yet. Although, you can download and build the CLI for your 
    platform from [this](https://github.com/rubikorg/okrubik) repository _(instructions provided inside README.md)_.
    It is not tested with this alpha release.

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