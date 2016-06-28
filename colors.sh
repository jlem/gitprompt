#!/bin/bash

#
# Color definitions
# DO NOT USE THESE IN PROMPTS DIRECTLY, use the P_ prefixed version for prompts below
#
R_CYAN="\033[38;5;30m"
R_BRIGHT_CYAN="\033[38;5;37m"
R_LIGHT_GRAY="\033[0;37m"
R_GREEN="\033[38;5;34m"
R_LIGHT_GREEN="\033[38;5;42m"
R_LIGHT_ORANGE="\033[38;5;215m"
R_ORANGE="\033[38;5;208m"
R_RED="\033[38;5;160m"
R_DARK_GRAY="\033[38;5;241m"
R_VERY_DARK_GRAY="\033[38;5;236m"
R_NC="\033[0m"

#
# Colors prefixed with P_ are prompt-safe, as they wrap the above colors with the correct escape characters
# If you plan on using any of these colors for your own prompt info, be sure to use these P_ prefixed colors
# else your prompt will exhibit weird wrapping behavior
#
P_CYAN="\[$R_CYAN\]"
P_BRIGHT_CYAN="\[$R_BRIGHT_CYAN\]"
P_LIGHT_GRAY="\[$R_LIGHT_GRAY\]"
P_GREEN="\[$R_GREEN\]"
P_LIGHT_GREEN="\[$R_LIGHT_GREEN\]"
P_LIGHT_ORANGE="\[$R_LIGHT_ORANGE\]"
P_ORANGE="\[$R_ORANGE\]"
P_RED="\[$R_RED\]"
P_DARK_GRAY="\[$R_DARK_GRAY\]"
P_VERY_DARK_GRAY="\[$R_VERY_DARK_GRAY\]"
P_NC="\[$R_NC\]"
