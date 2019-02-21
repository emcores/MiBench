include("buildconfig.jl")

@static if !parallel_build
    include("BuildMiBench.jl")
    using .BuildMiBench
else
    using Distributed
    addprocs(length(build_sub))
    # The following is a workaround
    Distributed.remotecall_eval(Main,procs(),:(include("BuildMiBench.jl")))
    Distributed.remotecall_eval(Main,procs(),:(using .BuildMiBench))
end

build_all = ("automotive","consumer","network","office","security","telecomm")

for b in build_sub
    if !any(b .== build_all)
        error("Requested build_sub ($b) is not a subset of build_all")
    end
end

buildpath = mkpath(joinpath("build",GCC))

@static if !parallel_build
    for b in build_sub
        wd = joinpath(buildpath,b)
        eval(Expr(:call,Symbol("build_"*b),wd))
    end
else
    println(build_sub)
    @sync @distributed for b in 1:length(build_sub)
        wd = joinpath(buildpath,build_sub[b])
        cp(build_sub[b],wd,force=true)
        eval(Expr(:call,Symbol("build_$(build_sub[b])"),wd))
    end
end
