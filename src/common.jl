
function timestamp()::Int
    return Int(Dates.datetime2unix(Dates.now()) * 1000)
end
