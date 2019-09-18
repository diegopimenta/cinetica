using DelimitedFiles, Printf

struct data
    CA0::Float64
    CB0::Float64
    dt::Float64
    ca
end

function f(Asim,Aexp)
    f = 0.e0
    for i in 1:length(Aexp)
        f = f + (Aexp[i]-Asim[i])^2
    end
    return f
end

function sim2( CA0, CB0, k1, km1; time = 100, dt = 1.e-1)
    nsteps = Int64(round(time/dt)) # Number of steps
    t = Vector{Float64}(undef,nsteps)
    CA = Vector{Float64}(undef,nsteps)
    CB = Vector{Float64}(undef,nsteps)
    CA[1] = CA0
    CB[1] = CB0
    t[1] = 0.
    for i in 2:nsteps
        CA[i] = CA[i-1] - k1*CA[i-1]*dt + km1*CB[i-1]*dt
        CB[i] = CA0 + CB0 - CA[i]
        # CB[i] = CB[i-1] - km1*CB[i-1]*dt + k1*CA[i-1]*dt
        t[i] = t[i-1] + dt
    end
    return t, CA, CB
end

function compute(K; expdata = expdata)
    k1 = K[1]
    km1 = K[2]
    t, ca, cb = sim2(expdata.CA0, expdata.CB0, k1, km1, dt = expdata.dt)
    return f(ca, expdata.ca)
end

file = readdlm("sim2/sim2.dat")
expdata = data(10., 1., 1.e-2, file[:,2])
popfirst!(expdata.ca)

k0 = [Vector{Float64}(undef,2) for i in 1:3]
for i in 1:3
  k0[i][1] = rand()
  k0[i][2] = rand()
end

include("simplex.jl")
niter = 1000
optvar, optf = simplex(compute,k0,niter)
println("\n\n", "---------> Best point found: ", " K = ", optvar, " || f = ", optf)
