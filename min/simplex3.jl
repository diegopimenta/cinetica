#
# Simplex minimization enhanced
#
struct pmin
    x
    y
    z
    f
end
struct point
    x
    y
    z
end

function simplex(f,x0,niter)
    # Initial point: x0 contains 3 vectors of dimension 2
    C = Vector{pmin}(undef,length(x0))
    # Initial function values
    for i in 1:length(C)
        C[i] = pmin(x0[i][1], x0[i][2], x0[i][3], f(x0[i]))
    end
    xav = point(undef, undef, undef)
    ptrial = pmin(undef, undef, undef, undef)
    ptemp = pmin(undef, undef, undef, undef)
    x = 0.
    y = 0.
    z = 0.
    println(" Initial points: ")
    for i in 1:3
        println(" (x, y, z, f)  ", C[i])
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
            println(" Best point found: ", " (x, y, z, f)  ", C[3])
            return C[1].x, C[1].y, C[1].z, C[1].f
        end
        # Compute averge of best points
        xav = point(0.5*(C[1].x + C[2].x), 0.5*(C[1].y + C[2].y), 0.5*(C[1].z + C[2].z))
        # Compute trial point
        x = C[3].x + 2*(xav.x - C[3].x)
        y = C[3].y + 2*(xav.y - C[3].y)
        z = C[3].z + 2*(xav.z - C[3].z)
        ptrial = pmin(x, y, z, f([x, y, z]))
        # If ftrial is better than fx[3], replace point 3 with trial point
        if ptrial.f < C[3].f
            C[3] = ptrial
            println(" Accepted point: ", " (x, y, z, f)  ", C[3])
        else
            println(" Function increased. Trying line search. ")
            # Try up to 10 different points in the
            # direction x[3]+gamma*(xtrial-x[3])
            for j in 1:20
                x = C[3].x + rand()*(ptrial.x - C[3].x)
                y = C[3].y + rand()*(ptrial.y - C[3].y)
                z = C[3].z + rand()*(ptrial.z - C[3].z)
                ptemp = pmin(x, y, z, f([x, y, z]))
                if ptemp.f < C[3].f
                    C[3] = ptemp
                    println("   Line search succeeded at trial ", j)
                    println("   New point: ", " (x, y, z, f)  ", C[3])
                    break # exits from line search loop
                end
            end
            # If the line search didn't find a better point, stop
            if ptemp.f > C[3].f
                println(" End of search. ")
                println(" Best point found: ", " (x, y, z, f)  ", C[1])
                return C[1].x, C[1].y, C[1].z, C[1].f
            end
        end
    end
    println(" Maximum number of trials reached. ")
    println(" Best point found: ", " (x, y, z, f)  ", C[3])
    return C[1].x, C[1].y, C[1].z, C[1].f
end
