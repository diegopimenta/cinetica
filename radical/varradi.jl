cfc0 = 0.003   # Initial concentration
oz0 = 1.
k1 = 0.001    # Velocity constant
k2 = 0.9
k3 = 0.1
time = 1. # Simulation time
dt = 1.e-4

t, CFC, RCL, RCFC, OZ, CLO, OX = radi(cfc0, oz0, k1, k2, k3, time, dt = dt)


#pyplot(right_margin=1,top_margin=1,framestyle=[:box])
plot(t, CFC, xlabel="Time (s)", ylabel="Concentration [X]", grid=false, label = "CFCl_3")
plot!(t, RCL, label = ".Cl")
plot!(t, RCFC, label = ".CFCl_2")
plot!(t, OZ, label = "O_3")
plot!(t, CLO, label = "ClO")
plot!(t, OX, label = "O_2")
plot!(framestyle=:box)

savefig("./radical/tudo.svg")
