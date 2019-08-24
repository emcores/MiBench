module BuildMiBench

export build_automotive,
    build_consumer,
    build_network,
    build_office,
    build_security,
    build_telecomm

function build_automotive(wd)
    println("Build: automotive")
    cwd=pwd()

    apps = ["basicmath","bitcount","qsort","susan"]
    println("Entering $wd ...")
    cd(wd)
    for app in apps
        cd(app)
        println("Building $app")
        run(`make`)
        cd("..")
    end
    cd(cwd)
end

function build_consumer(wd)
    println("Build: consumer")
    cwd=pwd()

    apps = ["jpeg","lame","mad","tiff-v3.5.4","typeset"]
    subdirs = ["jpeg-6a","lame3.70","mad-0.14.2b",".","lout-3.24"]
    println("Entering $wd ...")
    cd(wd)
    for (app,sub) in zip(apps,subdirs)
        cd(app)
        println("Building $app")
        cd(sub)
        if app == "tiff-v3.5.4"
            run(`./configure --noninteractive`)
        elseif app == "mad"
            run(`./configure --without-id3tag`)
        end
        run(`make`)
        cd("..")
        if app != "tiff-v3.5.4"
            cd("..")
        end
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
        println("Building $app")
        run(`make`)
        cd("..")
    end
    cd(cwd)
end

function build_office(wd)
    println("Build: office")
    cwd=pwd()

    apps = ["ghostscript","ispell","rsynth","sphinx","stringsearch"]
    println("Entering $wd ...")
    cd(wd)
    for app in apps
        cd(app)
        println("Building $app")
        if app == "ghostscript"
            cd("src")
            # use XCFLAGS to fix compilation error bug https://bugs.ghostscript.com/show_bug.cgi?id=692443
            run(`make XCFLAGS=-DHAVE_SYS_TIME_H=1`)
            cd("..")
        elseif app == "ispell"
            run(`make ispell`)
        elseif app == "rsynth"
            run(`./configure --host='x86_64-pc-linux-gnu'`)
            run(`make`)
        elseif app == "sphinx"
            run(`automake --add-missing`)
            run(`./configure`)
            run(`make`)
        elseif app == "stringsearch"
            run(`make`)
        end
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
    println("Building $app")
    cd("src")
    run(`make clean`)
    run(`make linux-portable`)
    cd("..")
    cd("..")

    # handle the rest of the apps
    for app in apps
        cd(app)
        println("Building $app")
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
    println("Building $app")
    cd("src")
    run(`make`)
    cd("..")
    cd("..")
    
    # handle the rest of the apps
    for app in apps
        cd(app)
        println("Building $app")
        run(`make`)
        cd("..")
    end
    cd(cwd)
end

end
