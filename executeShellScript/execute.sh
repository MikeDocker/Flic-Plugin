#!/bin/bash

# Author - Michael Paul Docker - mike.docker@gmail.com

# Some experiments with creating a Flic for Mac plugin to execute arbitary commands, such as running a node.js script to toggle the power state of a smart bulb.

# The numbered stages below are the steps I worked through whilst trying to get this plugin working and hopefully may prove useful
# to someone trying to write or troubleshoot their own plugin.

# 1 - Play a sound so we know something is happening.
# osascript -e beep

# 2 - Open a new Terminal window and execute a simple "hello world" command.
# We use a new Terminal window so we can see path and/or permissions errors more easily whilst developing the plugin.
# osascript -e 'tell app "Terminal"
#     do script "echo hello world"
# end tell'

# 3 - Open a new Terminal window and execute the node script that toggles the state of a smart bulb.
# N.B. We use absolute paths for certainty of where things are being read from.
# osascript -e 'tell app "Terminal"
#     do script "/usr/local/bin/node -r ~/Sites/home/kasa/node_modules/esm ~/Sites/home/kasa/kasa.js"
# end tell'

# 4 - Execute our script directly in the same process as Flic for Mac is using.
# You could stop at this step if your command is simple, but I wanted to be able to back mine up easily, hence step 5.
# /usr/local/bin/node -r ~/Sites/home/kasa/node_modules/esm ~/Sites/home/kasa/kasa.js

# 5 - Execute another shell script in the specified location.
# N.B. This is the final solution so we can make easy changes to our version of execute.sh and keep it under version control etc.
~/Sites/home/kasa/execute.sh

# osascript -e beep
