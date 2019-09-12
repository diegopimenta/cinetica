# Function to be minimized
f(x::Vector{Float64}) = x[1]^2 + x[2]^2
# Minimizer by random search
function randomsearch(f; ntrial=10000)
    fbest = 1.e30
    x = Vector{Float64}(undef,2)
    xbest = Vector{Float64}(undef,2)
    deltaf = 1.
    for i in 1:ntrial/10
        x[1] = -10. + 20. * rand()
        x[2] = -10. + 20. * rand()
        fx = f(x)
        if fx < fbest
            deltaf = fbest - fx
            fbest = fx
            xbest[1] = x[1]
            xbest[2] = x[2]
            # println(i," New best point: ", x," f(x) = ", fx)
        end
    end
    for i in 1:ntrial
        x[1] = xbest[1] + 1.e-1*(-1.e0 + 2.e0 * rand())
        x[2] = xbest[2] + 1.e-1*(-1.e0 + 2.e0 * rand())
        fx = f(x)
        if fx < fbest
            deltaf = fbest - fx
            fbest = fx
            xbest[1] = x[1]
            xbest[2] = x[2]
            println(i," New best point: ", x," f(x) = ", fx)
        end
    end
    println(" Best point found: ",xbest," f = ", fbest)
end
