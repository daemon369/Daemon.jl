using ZipFile

# https://github.com/sylvaticus/LAJuliaUtils.jl/blob/master/src/LAJuliaUtils.jl#L370
# ##############################################################################
# ##
# ## unzip()
# ##
# ##############################################################################
"""
unzip(file,exdir="")
Unzip a zipped archive using ZipFile
# Arguments
* `file`:    a zip archive to unzip and extract (absolure or relative path)
* `exdir=""`: an optional directory to specify the root of the folder where to extract the archive (absolute or relative).
# Notes:
* The function doesn't perform a check to see if all the zipped files have a common root.
# Examples
```julia
julia> unzip("myarchive.zip",exdir="mydata")
```
"""
function unzip(file::String, exdir::String="")
    fileFullPath = isabspath(file) ? file : joinpath(pwd(), file)
    basePath = dirname(fileFullPath)
    outPath = (exdir == "" ? basePath : (isabspath(exdir) ? exdir : joinpath(pwd(), exdir)))
    isdir(outPath) ? "" : mkdir(outPath)
    zarchive = ZipFile.Reader(fileFullPath)
    for f in zarchive.files
        fullFilePath = joinpath(outPath, f.name)
        if (endswith(f.name, "/") || endswith(f.name, "\\"))
            mkdir(fullFilePath)
        else
            write(fullFilePath, read(f))
        end
    end
    close(zarchive)
end
