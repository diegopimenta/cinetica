#
# Simplex minimization enhanced
#
struct pmin
    cord
    f
end

function simplex(f,x0,niter)
    # Initial point: x0 contains 3 vectors of dimension 2
    C = Vector{pmin}(undef,length(x0))
    # Initial function values
    for i in 1:length(C)
        C[i] = pmin(x0[i], f(x0[i]))
    end
    xav = Vector{Float64}(undef, length(x0[1]))
    ptrial = pmin(undef, undef)
    ptemp = pmin(undef, undef)
    x = 0.
    y = 0.
    println(" Initial points: ")
    for i in 1:3
        println(" ([cordinates], f)  ", C[i])
    end
    # Convergence criterium desired
    convcrit = 1.e-10
    # Main interation
    for iter in 1:niter
        println(" ------ ITERATION: ", iter)
        # Order the points from best to worst
        sort!(C, by = C -> C.f)
        # Check convergence
        if (C[3].f - C[2].f < convcrit) && (C[3].f - C[1].f < convcrit)
            println(" Precision reached. ")
            println(" Best point found: ", " ([cordinates], f)  ", C[1])
            return C[1].cord, C[1].f
        end
        # Compute averge of best points
        cav = similar(C[1].cord)
        for i in 1:length(C[1].cord)
            cav[i] = 0.5*(C[1].cord[i]+C[2].cord[i])
        end
        # Compute trial point
        ctrial = similar(cav)
        for i in 1:length(cav)
            ctrial[i] = C[3].cord[i] + 2*(cav[i] - C[3].cord[i])
        end
        ptrial = pmin(ctrial, f(ctrial))
        # If ftrial is better than fx[3], replace point 3 with trial point
        if ptrial.f < C[3].f
            C[3] = ptrial
            println(" Accepted point: ", " ([cordinates], f)  ", C[3])
        else
            println(" Function increased. Trying line search. ")
            # Try up to 10 different points in the
            # direction x[3]+gamma*(xtrial-x[3])
            ctemp = similar(C[1].cord)
            for j in 1:50
                for k in 1:length(C[1].cord)
                    ctemp[k] = C[3].cord[k] + rand()*(ptrial.cord[k] - C[3].cord[k])
                end
                ptemp = pmin(ctemp, f(ctemp))
                if ptemp.f < C[3].f
                    C[3] = ptemp
                    println("   Line search succeeded at trial ", j)
                    println("   New point: ", " ([cordinates], f)  ", C[3])
                    break # exits from line search loop
                end
            end
            # If the line search didn't find a better point, stop
            if ptemp.f > C[3].f
                println(" End of search. ")
                println(" Best point found: ", " ([cordinates], f)  ", C[1])
                return C[1].cord, C[1].f
            end
        end
    end
    println(" Maximum number of trials reached. ")
    println(" Best point found: ", " ([cordinates], f)  ", C[3])
    return C[1].cord, C[1].f
end
