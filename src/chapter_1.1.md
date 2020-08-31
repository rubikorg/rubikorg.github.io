# Installing okrubik

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
