
global showPrefix = true

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

# show verbose log
function v(io::IO, xs...)
    if logLevel == VERBOSE
        p(io, showPrefix ? "[V] " : "", xs...)
    end
end

function v(xs...)
    v(stdout, xs...)
end

# show verbose log
function d(io::IO, xs...)
    if logLevel <= DEBUG
        p(io, showPrefix ? "[D] " : "", xs...)
    end
end

function d(xs...)
    d(stdout, xs...)
end

# show info log
function i(io::IO, xs...)
    if logLevel <= INFO
        p(io, showPrefix ? "[I] " : "", xs...)
    end
end

function i(xs...)
    i(stdout, xs...)
end

# show warning log
function w(io::IO, xs...)
    if logLevel <= WARNING
        p(io, showPrefix ? "[W] " : "", xs...)
    end
end

function w(xs...)
    w(stdout, xs...)
end

# show error log
function e(io::IO, xs...)
    if logLevel <= ERROR
        p(io, showPrefix ? "[E] " : "", xs...)
    end
end

function e(xs...)
    e(stdout, xs...)
end
