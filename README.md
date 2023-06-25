[TOC]

# Daemon

[![Build Status](https://github.com/daemon369/Daemon.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/daemon369/Daemon.jl/actions/workflows/CI.yml?query=branch%3Amain)

# Tools

## android.jl

Android related tools

Function | Description
--- | ---
checkAdb | check whether adb tools exists, throw exception if not
selectSerial | if only on android device exists, return it; if multi-devices found, ask user to select one
getProp | Get android prop by propKey
showProp | Print android props
setProp | Set android prop to new value
resetProp | Reset android prop to empty
resetProps | Reset android props to empty

## timestamp.jl

Function | Description
--- | ---
timestamp | get current timestamp in millseconds

## log.jl

Log tools

Struct/Variable | Description
--- | ---
LogLevel | VERBOSE, DEBUG, INFO, WARNING, ERROR, QUIET
logLevel | LogLevel instance, presist global log level

Function | Description
--- | ---
setShowPrefix | enable/disable show prefix
getLogLevel | get current log level
setLogLevel | set current log level
p | print log
v | print verbose log
d | print debug log
i | print info log
w | print warning log
e | print error log

## zip.jl

Log tools

Function | Description
--- | ---
unzip | unzip zip archive