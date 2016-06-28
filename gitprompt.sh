#!/bin/bash

source ~/git-prompt.sh
source ~/Scripts/colors.sh

getGitPrompt () {

    local exit="$?"

    local addition_counter=0
    local modification_counter=0
    local deletion_counter=0
    local untracked_counter=0
    local staged_counter=0
    local unstaged_counter=0
    local conflicts_counter=0
    local stash_counter=0
    local ahead=0
    local behind=0

    local diff_string=""
    local stage_string=""
    local prompt_string=""
    local difference_string=""
    local branch_status=""
    local branch=""


    #
    # Parses the stash list from `git stash list`
    #
    function parseStash()
    {
        local stash_command="$(git stash list 2>/dev/null)"
        local stash_regex="^stash@"

        while read; do
            x="$REPLY"

            if [[ "$x" =~ $stash_regex ]]; then
                stash_counter=$[stash_counter + 1]
            fi
        done <<< "$stash_command"
    }

    #
    # Parses branch information and file modification status from `git status -sb`
    #
    # - Local branch name
    # - Number of commits ahead, number of commits behind remote
    # - Number of staged changes
    # - Number of unstaged changes
    # - Number of untracked files
    # - Number of stashed changes
    # - Number of conflicts
    #
    function parseStatus()
    {
        local status_command="$(git status --porcelain -b 2>/dev/null)"
        local ahead_regex="ahead ([0-9]+)"
        local behind_regex="behind ([0-9]+)"
        local initial_branch_regex="^## Initial commit on (.+)"
        local local_branch_regex="^## (.+)"
        local remote_branch_regex="^## (.+)\.\.\."
        local staged_regex="^[ADM][[:space:]][[:space:]]"
        local unstaged_regex="^[[:space:]][ADM][[:space:]]"
        local conflicts_regex="^UU"

        while read; do
            x="$REPLY"

            # Get conflicts count
            if [[ "$x" =~ $conflicts_regex ]]; then
                conflicts_counter=$[conflicts_counter + 1]
            fi

            # Get staged count
            if [[ "$x" =~ $staged_regex ]]; then
                staged_counter=$[staged_counter + 1] 
            fi

            # Get unstaged count
            if [[ "$x" =~ $unstaged_regex ]]; then
                unstaged_counter=$[unstaged_counter + 1] 
            fi

            # Get branch name
            if [[ "$x" =~ $initial_branch_regex ]]; then
                branch=${BASH_REMATCH[1]}
            elif [[ "$x" =~ $remote_branch_regex ]]; then
                branch=${BASH_REMATCH[1]}
            elif [[ "$x" =~ $local_branch_regex ]]; then
                branch=${BASH_REMATCH[1]}
            fi

            # Track if ahead: needs push
            if [[ "$x" =~ $ahead_regex ]]; then
               ahead=${BASH_REMATCH[1]}
            fi

            # Track if behind: needs pull
            if [[ "$x" =~ $behind_regex ]]; then
               behind=${BASH_REMATCH[1]}
            fi

            # Track additions
            if [[ "$x" =~ ^"A"[[:space:]]+ ]]; then 
                addition_counter=$[addition_counter + 1] 
            fi

            # Track modifications
            if [[ "$x" =~ ^"M"[[:space:]]+ ]]; then 
                modification_counter=$[modification_counter + 1] 
            fi

            # Track deletions
            if [[ "$x" =~ ^"D"[[:space:]]+ ]]; then 
                deletion_counter=$[deletion_counter + 1] 
            fi

            # Track untracked files
            if [[ "$x" =~ ^"??"[[:space:]]+ ]]; then 
                untracked_counter=$[untracked_counter + 1] 
            fi

        done <<< "$status_command"
    }

    #
    # Creates the string that displays staging and stash counts
    #
    # Example: 5∙2∙3∙15
    #
    # - First number is cyan, and is the number of staged modifications
    # - Second number is red, and is the number of unstaged modifications
    # - Third number is orange, and the is number of untracked files
    # - Fourth number is gray, and is the number of stashed changes
    #
    function buildStagingString()
    {
        if [[ $staged_counter > 0 ]]; then
            stage_string+="${P_VERY_DARK_GRAY}∙${P_BRIGHT_CYAN}${staged_counter}"
        fi

        if [[ $unstaged_counter > 0 ]]; then
            stage_string+="${P_VERY_DARK_GRAY}∙${P_RED}${unstaged_counter}"
        fi

        if [[ $untracked_counter > 0 ]]; then
            stage_string+="${P_VERY_DARK_GRAY}∙${P_ORANGE}${untracked_counter}"
        fi

        if [[ $stash_counter > 0 ]]; then
            stage_string+="${P_VERY_DARK_GRAY}∙${P_DARK_GRAY}${stash_counter}"
        fi

        stage_string+="${P_NC}"
    }

    #
    # Builds the string that shows how many commits ahead or behind the local branch is
    #
    # Example: [+10-5]
    #
    function buildDifferenceString()
    {
        if [[ -n "$branch" && $ahead > 0 && $behind == 0 ]]; then
            difference_string+="$P_DARK_GRAY[+$ahead] "
        fi

        if [[ -n "$branch" && $behind > 0 && $ahead == 0 ]]; then
            difference_string+="$P_DARK_GRAY[-$behind] "
        fi

        if [[ -n "$branch" && $ahead > 0 && $behind > 0 ]]; then
            difference_string+="$P_DARK_GRAY[+$ahead-$behind] "
        fi
    }
    
    #
    # Gets the icon for the current branch status
    #
    # * indicates the branch is out of sync with remote (either ahead or behind) 
    # ✓ indicates everything is ok! 
    # ⚠︎ indicates there are conflicts
    #
    function determineBranchStatus()
    {
        if [[ $ahead > 0 || $behind > 0 ]]; then
            branch_status=" *"
        fi

        if [[ $conflicts_counter > 0 ]]; then
            branch_status=" ⚠︎ "
        fi 

        if [[ $unstaged_counter == 0 && $staged_counter == 0 && $conflicts_counter == 0 && $ahead == 0 && $behind == 0 ]]; then
            branch_status=" ✓"
        fi
    }

    #
    # Final assembly of the prompt string
    #
    function assemblePromptString()
    {
        if [ -z "$branch" ]; then
            prompt_string=""
        elif [[ $ahead > 0 || $behind > 0 ]]; then
            prompt_string="$P_LIGHT_GREEN(${branch}${branch_status})"
        else
            prompt_string="$P_GREEN(${branch}${branch_status})"
        fi

        if [[ -n "$branch" && $unstaged_counter > 0 ]]; then
            prompt_string="$P_RED(${branch}${branch_status})"
        fi

        if [[ -n "$branch" && $staged_counter > 0 ]]; then
            prompt_string="$P_BRIGHT_CYAN(${branch}${branch_status})"
        fi

        if [[ -n "$branch" && $conflicts_counter > 0 ]]; then
            prompt_string="$P_RED{${branch}${branch_status}} [CONFLICTS: $conflicts_counter] "
        fi

        if [[ $difference_string != "" ]]; then
            prompt_string+="${difference_string}"
        fi

        PS1="${P_LIGHT_GRAY}\u ${P_CYAN}\w ${prompt_string}${stage_string} ${P_LIGHT_GRAY}$ "
    }

    parseStash
    parseStatus
    buildStagingString
    buildDifferenceString
    determineBranchStatus
    assemblePromptString

    return $exit
}
