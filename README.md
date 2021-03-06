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

| VARIABLE | DEFAULT VALUE
|----------|-------------|
|`GIT_PROMPT_SHOW_STASH_COUNT`| `true` |
|`GIT_PROMPT_SHOW_STAGING_COUNTS`| `true` |
|`GIT_PROMPT_SHOW_UNTRACKED_COUNT`| `true` |
|`GIT_PROMPT_SHOW_COMMIT_DELTA_COUNTS`| `true`
|`GIT_PROMPT_COLOR_STASH_COUNT` | `$P_DARK_GRAY` |
|`GIT_PROMPT_COLOR_UNTRACKED_COUNT`| `$P_ORANGE` |
|`GIT_PROMPT_COLOR_UNSTAGED`| `$P_RED` |
|`GIT_PROMPT_COLOR_STAGED`| `$P_BRIGHT_CYAN` |
|`GIT_PROMPT_COLOR_BRANCH_OUT_OF_SYNC`| `$P_LIGHT_GREEN` |
|`GIT_PROMPT_COLOR_BRANCH_OK`| `$P_GREEN` |
|`GIT_PROMPT_COLOR_COMMIT_DELTA_COUNTS`| `$P_DARK_GRAY` |
|`GIT_PROMPT_BRANCH_STATUS_ICON_OUT_OF_SYNC`| `' *'` |
|`GIT_PROMPT_BRANCH_STATUS_ICON_CONFLICT`| `' ⚠︎ '` |
|`GIT_PROMPT_BRANCH_STATUS_ICON_OK`| `' ✔'` |

### Example usage of configuration options
Simply export any of those options and their new values from your .bash_profile or .bashrc

```
export GIT_PROMPT_SHOW_UNTRACKED_COUNT=false
export GIT_PROMPT_COLOR_COMMIT_DELTA_COUNTS=$P_ORANGE
export GIT_PROMPT_BRANCH_STATUS_ICON_CONFLICT="!"
```

Colors can be any properly escaped prompt-safe color definition, but the provided `colors.sh` sourced at the top of your bash file offers a few named constants to use instead of the raw color codes.
