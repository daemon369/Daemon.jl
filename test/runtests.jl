using Daemon
using Test

@testset "Daemon.jl" begin
    # Write your tests here.
    @test (Daemon.@isdefined aaa) == false
    @test Daemon.verbose == false
    @test Daemon.quiet == false
    @test Daemon.showPrefix == true
    Daemon.setVerbose(true)
    @test Daemon.verbose == true
    Daemon.setShowPrefix(false)
    @test Daemon.showPrefix == false
    Daemon.v("verbose info")
end
