#! /usr/bin/bash
# call gh cli in a loop
while true; do clear && gh search prs --author @me --state open; sleep 60; done

