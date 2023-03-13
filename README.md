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

## common.jl

Function | Description
--- | ---
timestamp | get current timestamp in millseconds

## log.jl

Log tools

Function | Description
--- | ---
setVerbose | open/close verbose log
setQuiet | enable/disable quiet
setShowPrefix | enable/disable show prefix
p | print log
v | print verbose log
i | print info log
w | print warning log
e | print error log

## zip.jl

Log tools

Function | Description
--- | ---
unzip | unzip zip archive