
global verbose = false
global quiet = false

function setVerbose(v::Bool)
    global verbose = v
end

function setQuiet(q::Bool)
    global quiet = q
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
    if verbose && !quiet
        p(io, "[V] ", xs...)
    end
end

function v(xs...)
    v(stdout, xs...)
end

# show info log
function i(io::IO, xs...)
    if !quiet
        p(io, "[I] ", xs...)
    end
end

function i(xs...)
    i(stdout, xs...)
end

# show warning log
function w(io::IO, xs...)
    if !quiet
        p(io, "[W] ", xs...)
    end
end

function w(xs...)
    i(stdout, xs...)
end

# show error log
function e(io::IO, xs...)
    p(io, "[E] ", xs...)
end

function e(xs...)
    i(stdout, xs...)
end
