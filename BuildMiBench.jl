module BuildMiBench

export build_automotive,
    build_consumer,
    build_network,
    build_office,
    build_security,
    build_telecomm

build_consumer(wd) = println("build_consumer")
build_office(wd) = println("build_office")

function build_automotive(wd)
    println("Build: automotive")
    cwd=pwd()

    apps = ["basicmath","bitcount","qsort","susan"]
    println("Entering $wd ...")
    cd(wd)
    for app in apps
        cd(app)
        run(`make`)
        cd("..")
    end
    cd(cwd)
end

function build_network(wd)
    println("Build: network")
    cwd=pwd()

    apps = ["dijkstra","patricia"]
    println("Entering $wd ...")
    cd(wd)
    for app in apps
        cd(app)
        run(`make`)
        cd("..")
    end
    cd(cwd)
end

function build_security(wd)
    println("Build: security")
    cwd=pwd()

    apps = ["blowfish","pgp","rijndael","sha"]
    println("Entering $wd ...")
    cd(wd)
    # handle pgp separately
    app = "pgp"
    deleteat!(apps,apps .== app)
    cd(app)
    run(`make clean`)
    run(`make linux-portable`)
    cd("..")

    # handle the rest of the apps
    for app in apps
        cd(app)
        run(`make`)
        cd("..")
    end
    cd(cwd)
end

function build_telecomm(wd)
    println("Build: telecomm")
    cwd=pwd()

    apps = ["adpcm","CRC32","FFT","gsm"]
    println("Entering $wd ...")
    cd(wd)
    # handle adpcm separately
    app = "adpcm"
    deleteat!(apps,apps .== app)
    cd(app)
    cd("src")
    run(`make`)
    cd("..")
    cd("..")
    
    # handle the rest of the apps
    for app in apps
        cd(app)
        run(`make`)
        cd("..")
    end
    cd(cwd)
end

end
