using Daemon
using Test

@testset "Daemon.jl" begin
    # Write your tests here.
    println("isdefined")
    @test (Daemon.@isdefined aaa) == false
    println("isdefined passed\n")

    println("showPrefix")
    @test Daemon.showPrefix == true
    Daemon.setShowPrefix(false)
    @test Daemon.showPrefix == false
    println()

    println("verbose")
    Daemon.setVerbose(true)
    @test Daemon.logLevel == Daemon.VERBOSE
    Daemon.v("verbose log")
    Daemon.d("debug log")
    Daemon.i("info log")
    Daemon.w("warning log")
    Daemon.e("error log")
    println()
    Daemon.setLogLevel(VERBOSE)
    @test Daemon.logLevel == VERBOSE
    Daemon.v("verbose log 2")
    Daemon.d("debug log 2")
    Daemon.i("info log 2")
    Daemon.w("warning log 2")
    Daemon.e("error log 2")
    println()

    println("debug")
    Daemon.setLogLevel(DEBUG)
    @test Daemon.logLevel == DEBUG
    Daemon.v("verbose log 3")
    Daemon.d("debug log 3")
    Daemon.i("info log 3")
    Daemon.w("warning log 3")
    Daemon.e("error log 3")
    println()

    println("info")
    Daemon.setLogLevel(INFO)
    @test Daemon.logLevel == INFO
    Daemon.v("verbose log 4")
    Daemon.d("debug log 4")
    Daemon.i("info log 4")
    Daemon.w("warning log 4")
    Daemon.e("error log 4")
    println()

    println("warning")
    Daemon.setLogLevel(WARNING)
    @test Daemon.logLevel == WARNING
    Daemon.v("verbose log 5")
    Daemon.d("debug log 5")
    Daemon.i("info log 5")
    Daemon.w("warning log 5")
    Daemon.e("error log 5")
    println()

    println("error")
    Daemon.setLogLevel(ERROR)
    @test Daemon.logLevel == ERROR
    Daemon.v("verbose log 6")
    Daemon.d("debug log 6")
    Daemon.i("info log 6")
    Daemon.w("warning log 6")
    Daemon.e("error log 6")
    println()

    println("quiet")
    Daemon.setLogLevel(QUIET)
    @test Daemon.logLevel == QUIET
    Daemon.v("verbose log 7")
    Daemon.d("debug log 7")
    Daemon.i("info log 7")
    Daemon.w("warning log 7")
    Daemon.e("error log 7")
    println()
end
