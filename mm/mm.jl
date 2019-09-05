function mm( CE0, CS0, CES0, CP0, kr, kf, kcat, time; dt = 1.e-1)
    nsteps = Int64(round(time/dt)) # Number of steps
    t = Vector{Float64}(undef,nsteps)
    CE = Vector{Float64}(undef,nsteps)
    CS = Vector{Float64}(undef,nsteps)
    CES = Vector{Float64}(undef,nsteps)
    CP = Vector{Float64}(undef,nsteps)
    CE[1] = CE0
    CS[1] = CS0
    CES[1] = CES0
    CP[1] = CP0
    t[1] = 0.
    for i in 2:nsteps
        CS[i] = CS[i-1] - kr*CS[i-1]*CE[i-1]*dt + kf*CES[i-1]*dt
        if CS[i] < 0.
            CS[i] = 0.
        end
        CE[i] = CE[i-1] - kr*CS[i-1]*CE[i-1]*dt + kf*CES[i-1]*dt + kcat*CES[i-1]*dt
        if CE[i] < 0.
            CE[i] = 0.
        end
        CES[i] = CES[i-1] - kf*CES[i-1]*dt - kcat*CES[i-1]*dt + kr*CS[i-1]*CE[i-1]*dt
        if CES[i] < 0.
            CES[i] = 0.
        end
        CP[i] = CP0 + CS0 - CS[i]
        if CP[i] < 0.
            CP[i] = 0.
        end
        t[i] = t[i-1] + dt
    end
    return t, CE, CS, CES, CP
end
using Plots
