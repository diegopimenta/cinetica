function min4(x0, y0; prec = 1.e-7, passe = 0.1)
    xbest = x0
    ybest = y0
    fbest = xbest^2 + ybest^2 # Best value up to now
    println(" Initials points: "," x: ",xbest, "     y: ", ybest, "    f: ",fbest)
    steps = 0
    passe = [passe, passe]
    while steps < 1
        # Move x in the descent direction, with step deltax
        dfdx = 2xbest
        dfdy = 2*ybest
        grad = [dfdx, dfdy]
        if sqrt(grad[1]^2+grad[2]^2) < prec                # Computing the derivative
            println(" Function is increasing. ")
            println(" Best solution found: x = ", round(xbest, digits = 5), "y = ", round(ybest, digits = 5), " f(x) = ",round(fbest, digits = 5))
            return xbest, ybest, fbest
        end
        best = [xbest, ybest]
        trial = best - (@. grad * passe)      # Move x in the -f' direction
        # Test new point
        ftrial = trial[1]^2 + trial[2]^2
        # Write current point
        println("Current point: ",trial[1],", ",trial[2],"   ", ftrial, "   ", passe)
        # If the function decreased, save best point
        if ftrial < fbest
            xbest = trial[1]
            ybest = trial[2]
            fbest = ftrial
            passe = passe * 2
        else
            passe = passe/2
        end
        # steps += 1
    end
end
