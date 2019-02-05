# Some notes on developing a simple Flic for Mac plugin

## Introduction

When I first started experimenting with the [Flic for Mac](https://flic.io/mac-app) application I wanted to be able to run a node.js script stored outside the Flic plugins folder and eventually to be able to use a [Flic button](https://flic.io) to do the same.

I started out by making a copy of the [Screenshot plugin](http://macplugins.flic.io) that comes bundled with the Flic for Mac application and renaming it.

Flic for Mac plugins are stored in
```
~/Library/Application Scripts/com.shortcutlabs.FlicMac
```
I modified my copy of **execute.sh** to run my node script and created a Flic for Mac widget to run the plugin.

When I tried executing the plugin via the widget nothing happened and frustratingly there was no error message or other feedback that I could find.

What follows are some notes on how I got things working and a couple of troubleshooting tips I discovered along the way. Hopefully, this may be of use to someone else when developing a Flic for Mac plugin.

I finish with the final version of my plugin that can execute an arbitrary shell script stored on my Mac but outside of the Flic for Mac plugins directory.

### Step 1 - Play a sound using AppleScript

I found it helpful to play a sound at the start and end of my copy of **execute.sh** so I knew if something was happening and how long it was taking to happen.

```
# Play a sound at the start so we know something is happening.
osascript -e beep

# The command I'm trying to make work and need some help troubleshooting.
node ~/scripts/index.js

# Play a sound at the end so we know how long it took to complete.
osascript -e beep
```

The node script toggles the power state of a smart lightbulb and takes 2 or 3 seconds to complete when run independently of the Flic app.

Executing the script via the Flic widget had no effect on the state of the light bulb and executed much more quickly than normal, so I guessed there was an error somewhere and an error message that I needed to see.

### Step 2 - Launch a Terminal window

The next thing I tried was launching a Terminal window from my copy of **execute.sh** and running a simple "hello world" script in the newly opened window.

```
osascript -e 'tell app "Terminal"
     do script "echo hello world"
 end tell'
```

So far so good, I could see the "hello world" message in the Terminal window. Now it was time to try running my own script.

```
osascript -e 'tell app "Terminal"
     do script "node ~/scripts/index.js"
 end tell'
```

And I could immediately see I had path issues and a missing requirement.

In my finished plugin I decided to use **execute.sh** to call another shell script stored elsewhere on my Mac (under version control and part of a backup regime) that I could also modify easily without needing to reload the plugin.

## Execute arbitrary shell script

Plugin for Flic for Mac to execute an arbitrary shell script located outside the plugins directory.

<p align="center">
![Screenshot of the ExecuteShellScript Plugin](https://github.com/MikeDocker/Flic-Plugin/blob/master/screenshot.png?raw=true)
</p>
