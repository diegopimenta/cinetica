function min(X, f, g; prec = 1.e-3, passe = 0.01)
    Xbest = X
    fbest = f(X) # Best value up to now
    # println(" Initials points: "," x: ",xbest, "     y: ", ybest, "    f: ",fbest)
    steps = 0
    # passe = [passe, passe]
    while steps < 1
        # Move x in the descent direction, with step deltax
        grad = g(Xbest)
        if sqrt(sum(@. grad^2)) < prec                # Computing the derivative
            println(" Critical point achieved. ")
            # println(" Best solution found: x = ", round(xbest, digits = 5), "y = ", round(ybest, digits = 5), " f(x) = ",round(fbest, digits = 5))
            return Xbest, fbest
        end
        # Xtrial = similar(Xbest)
        Xtrial = Xbest - (@. grad * passe)      # Move x in the -f' direction
        # Test new point
        ftrial = f(Xtrial)
        # Write current point
        println("Current passe ", passe)
        # If the function decreased, save best point
        if ftrial < fbest
            Xbest = Xtrial
            fbest = ftrial
            passe = passe * 2
        else
            passe = passe/2
            if passe < 1.e-10
                return Xbest, fbest
            end
        end
        # steps += 1
    end
end
