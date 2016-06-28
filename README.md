# Example Usage
Example usage in .bash_profile or .bashrc
```
source ./gitprompt.sh

function makePrompt()
{
    PS1="\u \w `getGitPrompt` $ "
}

PROMPT_COMMAND=makePrompt
```

You can place the `gitprompt.sh` file anywhere, just be sure to place `colors.sh` in the same directory, and then change the source in bash_profile or bashrc

# Configuration Options
Export any of the following configuration variables from your .bash_profile or .bashrc file

#### Hide stash count:
`export GIT_PROMPT_SHOW_STASH_COUNT=false`

#### Hide staging info:
`export GIT_PROMPT_SHOW_STAGING_COUNTS=false`

#### Hide untracked file count:
`export GIT_PROMPT_SHOW_UNTRACKED_COUNT=false`

#### Hide commit deltas between local and remote
`export GIT_PROMPT_SHOW_COMMIT_DELTA_COUNTS=false`
