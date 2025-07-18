#!/bin/sh
if command -v powerprofilesctl >/dev/null 2>&1; then
    profile=$(powerprofilesctl get 2>/dev/null)
    if [ -n "$profile" ]; then
        echo "{\"alt\": \"$profile\"}"
    else
        echo "{\"alt\": \"unknown\"}"
    fi
else
    echo "{\"alt\": \"unavailable\"}"
fi
