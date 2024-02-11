# Commit Message Script

This script is designed to help you create structured and consistent commit messages.

## How it works

When you run the script, it will ask you a series of questions:

1. What type is it? (Options: feat, fix, docs, chore, style, refactor, test, perf, ci, build)
2. In which scope? (Example: auth, api, db...)
3. A description of the commit.
4. Are there any breaking changes? (y/n)
5. A body for the commit message.
6. Are there any issues/PR closed by this commit? (y/n)

Based on your answers, the script will create a commit message that follows a structured format.

## Usage

To use the script, simply run it in your terminal:

```sh
./script.sh
```

Please note that you may need to make the script executable first:

```sh
chmod +x script.sh
```

## Example

![Example](https://github.com/Lainocs/conventional-commits-helper/blob/main/example.png?raw=true)

Currently, you have to run the script in the same directory as the script itself. I'm working on a solution to make it more flexible.

Maybe something like Homebrew's `brew` command, where you can run it from anywhere.
