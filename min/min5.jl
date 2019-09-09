function min5(X; prec = 1.e-3, passe = 0.1)
    Xbest = X
    fbest = sum(@. Xbest^2) # Best value up to now
    # println(" Initials points: "," x: ",xbest, "     y: ", ybest, "    f: ",fbest)
    steps = 0
    # passe = [passe, passe]
    while steps < 1
        # Move x in the descent direction, with step deltax
        grad = similar(Xbest)
        for i in 1:length(grad)
            grad[i] = 2*Xbest[i]
        end

        if sqrt(sum(@. grad^2)) < prec                # Computing the derivative
            println(" Critical point achieved. ")
            # println(" Best solution found: x = ", round(xbest, digits = 5), "y = ", round(ybest, digits = 5), " f(x) = ",round(fbest, digits = 5))
            return Xbest, fbest
        end
        # Xtrial = similar(Xbest)
        Xtrial = Xbest - (@. grad * passe)      # Move x in the -f' direction
        # Test new point
        ftrial = sum(@. Xtrial^2)
        # Write current point
        # println("Current point: ",trial[1],", ",trial[2],"   ", ftrial, "   ", passe)
        # If the function decreased, save best point
        if ftrial < fbest
            Xbest = Xtrial
            fbest = ftrial
            passe = passe * 2
        else
            passe = passe/2
        end
        # steps += 1
    end
end
