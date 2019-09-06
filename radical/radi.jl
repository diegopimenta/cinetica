function radi(cfc0, oz0, k1, k2, k3, time; dt = 1.e-1)
    nsteps = Int64(round(time/dt)) # Number of steps
    t = Vector{Float64}(undef,nsteps)
    CFC = Vector{Float64}(undef,nsteps)
    RCL = Vector{Float64}(undef,nsteps)
    RCFC = Vector{Float64}(undef,nsteps)
    OZ = Vector{Float64}(undef,nsteps)
    CLO = Vector{Float64}(undef,nsteps)
    OX = Vector{Float64}(undef,nsteps)
    t[1] = 0.
    CFC[1] = cfc0
    RCL[1] = 0.
    RCFC[1] = 0.
    OZ[1] = oz0
    CLO[1] = 0.
    OX[1] = 0.
    for i in 2:nsteps
        CFC[i] = CFC[i-1] - k1*CFC[i-1]
        if CFC[i] < 0.
            CFC[i] = 0.
        end
        RCL[i] = RCL[i-1] + k1*CFC[i-1] - k2*OZ[i-1]*RCL[i-1] + k3*CLO[i-1]*OZ[i-1]
        if RCL[i] < 0.
            RCL[i] = 0.
        end
        RCFC[i] = RCFC[i-1] + k1*CFC[i-1]
        if RCFC[i] < 0.
            RCFC[i] = 0.
        end
        OZ[i] = OZ[i-1] - k2*OZ[i-1]*RCL[i-1] - k3*CLO[i-1]*OZ[i-1]
        if OZ[i] < 0.
            OZ[i] = 0.
        end
        CLO[i] = CLO[i-1] + k2*OZ[i-1]*RCL[i-1] - k3*CLO[i-1]*OZ[i-1]
        if CLO[i] < 0.
            CLO[i] = 0.
        end
        OX[i] = OX[i-1] + k2*OZ[i-1]*RCL[i-1] + k3*CLO[i-1]*OZ[i-1]
        if OX[i] < 0.
            OX[i] = 0.
        end
        t[i] = t[i-1] + dt
    end
    return t, CFC, RCL, RCFC, OZ, CLO, OX
end
using Plots
