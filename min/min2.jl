function min2(x0; deltax = 0.01)
    x = x0
    xbest = x # Save best point
    fbest = x^2 + sin(10*x) # Best value up to now
    println(" Initial point: ",xbest," ",fbest)
    deltaf = -1.
    while deltaf < 0.
        # Move x in the descent direction, with step deltax
        dfdx = 2*x + 10cos(10x) # Computing the derivative
        x = x - deltax * dfdx # Move x in the -f' direction
        # Test new point
        deltaf = x^2 + sin(10*x) - fbest
        # Write current point
        println("Current point: ",x," ",x^2," ",deltaf)
        # If the function decreased, save best point
        if deltaf < 0.
            xbest = x
            fbest = x^2
        else
            println(" Function is increasing. ")
            println(" Best solution found: x = ", round(xbest, digits = 20), " f(x) = ",round(fbest, digits = 20))
            return xbest, fbest
        end
    end
end
