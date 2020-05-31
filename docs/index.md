<p align="center">
<img style="background: transparent; border-width: 0px; width: 150px;" src="/img/icon.png">
</p>

<p align="center" style="padding-left:4em;padding-right:4em;text-align:justify;text-justify:inter-word;">
Rubik is a efficient, scalable micro-framework for writing REST client and server-side applications. It provides a pluggable
layer of abstraction over `net/http` and enables automation of development environment through extensive tooling.
<br/>
<br/>
Rubik aims to deliver similar experience on projects of different scale and keep support of existing Go's `net/http` 
interfaces for cross-compatibility.
</p>

<h2 align="center">Quickstart</h2>

<br />

<p align="center">
<iframe id="quick-demo" width="560" height="315" src="https://www.youtube.com/embed/bUx066QTwfE?controls=0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

</p>

<br /><br />
<hr/>

# Installation

Rubik comes with it's own generator CLI called `okrubik`. Copy and paste the below command to install
the CLI tool.

<span style="font-weight: bold">Shell</span>: _(Alpha)_
```bash
curl https://rubik.ashishshekar.com/install | sh
```

!!! Note
    okrubik is not supported for Windows yet. Although you can download and build the CLI for your 
    platform from [this](https://github.com/rubikorg/okrubik) repository. It is not tested with this
    release.

### Create Project

After your project is installed to the path you can easily create a Rubik project by running the
`create` command:

```bash
okrubik create
```

You'll be presented with some questions before setting up your Rubik server. After you answer them
a directory will be created with your project name.

### Running Project

You can run the project by using the `run` command:

```bash
okrubik run
```

You will see a chooser to run which of the projects in your Rubik workspace. After you choose
_server_ you can see your Rubik server running at _PORT_ you had entered. You'll see a page like so:

<img width="500" src="/img/new_project.png" />

!!! Success
    Congratulations on your Rubik project setup! You will have all the resources at your disposal
    for quickly writing REST APIs in that page.


# Framework Documentation

The framework is new and needs many documentation that needs to be added. The current documentation of Rubik framework can be found [here](https://pkg.go.dev/github.com/rubikorg/rubik?tab=doc).

# Disclaimer!

This project is still in `alpha` stage. Meaning, that it should not be used for writing complex and 
information sensitive servers -- "yet". As this project is made support the needs of an upcoming product
that is due to be launched this year, it'll receive huge updates and in-time it will become 
[rock solid!]()

# However...

This alpha release of Rubik can be used for quick prototying and proof-of-concept servers for your
ideas.