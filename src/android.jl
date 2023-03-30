struct AndroidDevice
    serial::String
    state::String
end

function parseAndroidDevice(deviceInfo::AbstractString)
    if isempty(deviceInfo)
        return Nothing
    end
    local s = split(deviceInfo)
    return AndroidDevice(s[1], s[2])
end

function checkAdb()
    local adb = Sys.which("adb")
    if isempty(adb)
        throw(ErrorException("adb not found"))
    end
end

#=
selectSerial
If multi-devices exists, let user choose one and return it's serial;
if only one device exists, choose that one and return it's serial;
if no device exists, throw ErrorException
=#
function selectSerial()::String
    checkAdb()
    local adbDevices::String = readchomp(`adb devices`)
    v("adb devices: $adbDevices")
    local lines = split(adbDevices, "\n")
    v("lines=$lines")
    local devices::Vector{AndroidDevice} = []

    for i in 2:lastindex(lines)
        if !isempty(lines[i])
            local d = parseAndroidDevice(lines[i])
            if d isa AndroidDevice
                push!(devices, d)
            end
        end
    end

    v("devices=$devices")
    if length(devices) == 0
        throw(ErrorException("android device not found"))
    elseif length(devices) == 1
        return devices[1].serial
    else
        p("请选择设备：")
        for i in eachindex(devices)
            p("\t$i: $(devices[i].serial)\t\t$(devices[i].state)")
        end
        local index::Int = 0

        while true
            try
                index = parse(Int, readline())
            catch
            end
            if index >= 1 && index <= length(devices)
                return devices[index].serial
            else
                p("输入非法，请输入设备编号：")
            end
        end
    end
end
