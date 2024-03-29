# Simplex Var
#
include("./simplex3.jl")

# Function to be minimized
f(x::Vector{Float64}) = x[1]^2 + x[2]^2 + x[3]^2

# Initial point 3 vectors of dimension 2
x0 = [ Vector{Float64}(undef,3) for i in 1:3 ]
for i in 1:3
  x0[i][1] = -10. + 20. * rand()
  x0[i][2] = -10. + 20. * rand()
  x0[i][3] = -10. + 20. * rand()
end

# Minimize
niter = 1000
simplex(f,x0,niter)
