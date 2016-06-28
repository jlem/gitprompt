Example usage in .bash_profile or .bashrc
```
source ./gitprompt.sh

function makePrompt()
{
    PS1="\u \w `getGitPrompt` $"
}

PROMPT_COMMAND=makePrompt
```

You can place the `gitprompt.sh` file anywhere, just be sure to place `colors.sh` in the same directory, and then change the source in bash_profile or bashrc
