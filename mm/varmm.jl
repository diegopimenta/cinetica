CE0 = 0.3   # Initial concentration
CS0 = 1.
CES0 = 0.
CP0 = 0.
kr = 0.03    # Velocity constant
kf = 0.015
kcat = 0.05
time = 200. # Simulation time
dt = 1.e-4

t, CE, CS, CES, CP = mm(CE0, CS0, CES0, CP0, kr, kf, kcat, time, dt = dt)


#pyplot(right_margin=1,top_margin=1,framestyle=[:box])
plot(t, CE, xlabel="Time (s)", ylabel="Concentration [X]", grid=false, label = "E")
plot!(t, CS, label = "S")
plot!(t, CES, label = "CES")
plot!(t, CP, label = "CP")
plot!(framestyle=:box)

savefig("./mm/mm.svg")
