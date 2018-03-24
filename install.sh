#!/usr/bin/env bash

SOURCERER_URL="https://raw.githubusercontent.com/mstruebing/sourcerer/master/sourcerer"
SOURCERER_DIR="$HOME/.sourcerer"
SOURCERER_FILE="$SOURCERER_DIR/sourcerer"

### BEGIN THANKS NVM
try_profile() {
    if [ -z "${1-}" ] || [ ! -f "${1}" ]; then
        return 1
    fi
    echo "${1}"
}

#
# Detect profile file if not specified as environment variable
# (eg: PROFILE=~/.myprofile)
# The echo'ed path is guaranteed to be an existing file
# Otherwise, an empty string is returned
#
detect_profile() {
    if [ -n "${PROFILE}" ] && [ -f "${PROFILE}" ]; then
        echo "${PROFILE}"
        return
    fi

    local DETECTED_PROFILE
    DETECTED_PROFILE=''
    local SHELLTYPE
    SHELLTYPE="$(basename "/$SHELL")"

    if [ "$SHELLTYPE" = "bash" ]; then
        if [ -f "$HOME/.bashrc" ]; then
            DETECTED_PROFILE="$HOME/.bashrc"
        elif [ -f "$HOME/.bash_profile" ]; then
            DETECTED_PROFILE="$HOME/.bash_profile"
        fi
    elif [ "$SHELLTYPE" = "zsh" ]; then
        DETECTED_PROFILE="$HOME/.zshrc"
    fi

    if [ -z "$DETECTED_PROFILE" ]; then
        for EACH_PROFILE in ".profile" ".bashrc" ".bash_profile" ".zshrc"
        do
            if DETECTED_PROFILE="$(try_profile "${HOME}/${EACH_PROFILE}")"; then
                break
            fi
        done
    fi

    if [ ! -z "$DETECTED_PROFILE" ]; then
        echo "$DETECTED_PROFILE"
    fi
} ### END THANKS NVM

install() {
    mkdir -p "$SOURCERER_DIR"
    curl -H 'Cache-Control: no-cache' "$SOURCERER_URL" -o "$SOURCERER_FILE"  &>/dev/null

    local profile
    profile=$(detect_profile)

    echo "" >> "$profile"
    echo "# Source the sourcerer" >> "$profile"
    echo source "$SOURCERER_FILE" >> "$profile"
}

install
