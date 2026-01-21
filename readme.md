simple program to draw borders on screen to highlight active apps on mac.
something like JankyBorders: https://github.com/FelixKratz/JankyBorders

build using "swift build -c release", then copy executable to "/usr/local/bin" and launch agent to "/Library/LaunchAgents" as the installer(install.swift) is still incomplete

start background service using "swiftborders --start"
stop background service using "swiftborders --stop"

todo:

- fix broken install + launch agent
- config file
- app whitelist or blacklist

- bugs, testing
