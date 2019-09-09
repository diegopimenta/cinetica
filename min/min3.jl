function min3(x0, prec; deltax = 0.01)
    x = x0
    xbest = x # Save best point
    fbest = x^2 + 3 # Best value up to now
    println(" Initial point: ",xbest," ",fbest)
    steps = 0
    while steps < 1
        # Move x in the descent direction, with step deltax
        dfdx = 2*xbest
        if abs(dfdx) < prec                 # Computing the derivative
            println(" Function is increasing. ")
            println(" Best solution found: x = ", round(xbest, digits = 20), " f(x) = ",round(fbest, digits = 20))
            return xbest, fbest
        end
        xtrial = xbest - deltax * dfdx      # Move x in the -f' direction
        # Test new point
        ftrial = xtrial^2
        # Write current point
        # println("Current point: ",x," ",x^2," ",deltaf)
        # If the function decreased, save best point
        if ftrial < fbest
            xbest = xtrial
            fbest = ftrial
            deltax = deltax * 2
        else
            deltax = deltax/2
        end
        # steps += 1
    end
end
