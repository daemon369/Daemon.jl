module Daemon

export timestamp
export v, d, i, w, e, p, setShowPrefix, logLevel, setLogLevel, getLogLevel,
    getShowPid, setShowPid, getShowTimestamp, setShowTimestamp, getShowTid, setShowTid, getShowLogLevel, setShowLogLevel,
    VERBOSE, DEBUG, INFO, WARNING, ERROR, QUIET
export unzip
export checkAdb, selectSerial, getProp, showProp, setProp, resetProp, resetProps

include("macro.jl")
include("timestamp.jl")
include("log.jl")
include("zip.jl")
include("android.jl")

end # module Daemon
