using Printf

global showPrefix = true
global showPid = true
global showTid = true
global showLogLevel = true

@enum LogLevel begin
    VERBOSE
    DEBUG
    INFO
    WARNING
    ERROR
    QUIET
end

logLevel = INFO

function setShowPrefix(s::Bool)
    global showPrefix = s
end

function getLogLevel()::LogLevel
    return logLevel
end

function setLogLevel(level::LogLevel)
    global logLevel = level
end

function getShowPid()::Bool
    return showPid
end

function setShowPid(s::Bool)
    global showPid = s
end

function getShowTid()::Bool
    return showTid
end

function setShowTid(s::Bool)
    global showTid = s
end

function getShowLogLevel()::Bool
    return showLogLevel
end

function setShowLogLevel(s::Bool)
    global showLogLevel = s
end


function p(io::IO, prefix::AbstractString, xs...)
    lock(io)
    try
        local ss = split(join(xs), "\n")
        for x in ss
            print(io, prefix, x, "\n")
        end
    finally
        unlock(io)
    end
    return nothing
end

function p(prefix::AbstractString, xs...)
    p(stdout, prefix, xs...)
end

function l(io::IO, prefix::AbstractString, xs...)
    local ss = split(join(xs), "\n")
    if showPrefix
        local pid = getpid()
        local tid = Threads.threadid()
        for x in ss
            if showPid && showTid
                if showLogLevel
                    @printf("%8d%8d %s %s\n", pid, tid, prefix, x)
                else
                    @printf("%8d%8d %s\n", pid, tid, x)
                end
            elseif showPid
                if showLogLevel
                    @printf("%8d %s %s\n", pid, prefix, x)
                else
                    @printf("%8d %s\n", pid, x)
                end
            elseif showTid
                if showLogLevel
                    @printf("%8d %s %s\n", tid, prefix, x)
                else
                    @printf("%8d %s\n", tid, x)
                end
            else
                if showLogLevel
                    @printf("%s %s\n", prefix, x)
                else
                    @printf("%s\n", x)
                end
            end
        end
    end
end

# show verbose log
function v(io::IO, xs...)
    if logLevel == VERBOSE
        l(io, "V", xs...)
    end
end

function v(xs...)
    v(stdout, xs...)
end

# show verbose log
function d(io::IO, xs...)
    if logLevel <= DEBUG
        l(io, "D", xs...)
    end
end

function d(xs...)
    d(stdout, xs...)
end

# show info log
function i(io::IO, xs...)
    if logLevel <= INFO
        l(io, "I", xs...)
    end
end

function i(xs...)
    i(stdout, xs...)
end

# show warning log
function w(io::IO, xs...)
    if logLevel <= WARNING
        l(io, "W", xs...)
    end
end

function w(xs...)
    w(stdout, xs...)
end

# show error log
function e(io::IO, xs...)
    if logLevel <= ERROR
        l(io, "E", xs...)
    end
end

function e(xs...)
    e(stdout, xs...)
end
