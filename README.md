# Quick Installation
`cd ~ && git clone https://github.com/jlem/gitprompt.git`

Feel free to move this anywhere, but remember to source both `colors.sh` and `gitprompt.sh`

# Example Usage
Example usage in .bash_profile or .bashrc
```
source ~/gitprompt/colors.sh
source ~/gitprompt/gitprompt.sh

function makePrompt()
{
    PS1="\u \w `getGitPrompt` $ "
}

PROMPT_COMMAND=makePrompt
```

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

# Color configuration options
Below the are the configurable colors for git prompt, and their defaults. Simply export and override any of those variables from .bash_profile or .bashrc
```
GIT_PROMPT_COLOR_STASH_COUNT (default is $P_DARK_GRAY)
GIT_PROMPT_COLOR_UNTRACKED_COUNT (default is $P_ORANGE)
GIT_PROMPT_COLOR_UNSTAGED (default is $P_RED)
GIT_PROMPT_COLOR_STAGED (default is $P_BRIGHT_CYAN)
GIT_PROMPT_COLOR_BRANCH_OUT_OF_SYNC (default is $P_LIGHT_GREEN)
GIT_PROMPT_COLOR_BRANCH_OK (default is $P_GREEN)
GIT_PROMPT_COLOR_COMMIT_DELTA_COUNTS (default is $P_DARK_GRAY)
```
