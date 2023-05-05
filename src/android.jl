struct AndroidDevice
    serial::String
    state::String
end

noDevice = AndroidDevice("", "")


"""
    parseAndroidDevice(deviceInfo::AbstractString)::AndroidDevice

Parse android device info line to AndroidDevice
"""
function parseAndroidDevice(deviceInfo::AbstractString)::AndroidDevice
    if isempty(deviceInfo)
        return noDevice
    end
    local s = split(deviceInfo)
    return AndroidDevice(s[1], s[2])
end


"""
    checkAdb()

Check whether adb command is accessable
"""
function checkAdb()
    local adb = Sys.which("adb")
    if isempty(adb)
        throw(ErrorException("adb not found"))
    end
end


"""
    selectSerial()::String

Select android device and return it's serial

1. If multi-devices exists, let user choose one and return it's serial;
2. If only one device exists, choose that one and return it's serial;
3. If no device exists, throw ErrorException
"""
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
            if d != noDevice
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


"""
    getProp(propKey)::AbstractString

Get android prop by propKey
"""
function getProp(propKey)::AbstractString
    return readchomp(`adb shell getprop $propKey`)
end


"""
    showProp(props)

Print android props
"""
function showProp(props)
    p("==============================================================")
    p(">> get prop\n")

    d("typeof(props): $(typeof(props))")

    if props isa String
        v("is a String")
        local splited = split(props)
        if length(splited) == 1
            prop = getProp(props)
            println("$props=$prop")
        else
            showProp(splited)
        end
    elseif isa(props, Vector) || isa(props, Array) || isa(props, Dic)
        if isa(props, Vector)
            v("is a Vector")
        elseif isa(props, Array)
            v("is a Array")
        elseif isa(props, Dic)
            v("is a Dic")
        end
        for x in props
            prop = getProp(x)
            println("$x=$prop")
        end
    end

    p("\n<< get prop")
    p("==============================================================")
end


"""
    setProp(prop::AbstractString, value::AbstractString)

Set android prop to new value
"""
function setProp(prop::AbstractString, value::AbstractString)
    p("==============================================================")
    p(">> set prop $(prop) $(value)\n")

    before = getProp(prop)

    run(`adb shell setprop $prop $value`)

    after = getProp(prop)

    p("$before=>$(after)")

    p("\n<<  set prop $(prop) $(value)")
    p("==============================================================")
end


"""
    resetProp(prop)

Reset android prop to empty
"""
function resetProp(prop)
    d("resetProp($(prop))")
    local current = getProp(prop)
    p(prop)
    d("resetProp current=$current")
    readchomp(`adb shell setprop $prop \"\"`)
end


"""
    resetProps(props)

Reset android props to empty
"""
function resetProps(props)
    p("==============================================================")
    p(">> reset props\n")

    d("typeof(props): $(typeof(props))")

    if props isa String
        v("is a String")
        resetProp(props)
    elseif isa(props, Vector) || isa(props, Array) || isa(props, Dic)
        if isa(props, Vector)
            v("is a Vector")
        elseif isa(props, Array)
            v("is a Array")
        elseif isa(props, Dic)
            v("is a Dic")
        end
        for x in props
            resetProp(x)
        end
    end

    p("\n<< reset props")
    p("==============================================================")
end
