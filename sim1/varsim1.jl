
CA0 = 10. # Initial concentration
CB0 = 0.
k1 = 0.1 # Velocity constant
time = 100. # Simulation time
dt = 1.e-2

t, ca, cb = sim1( CA0, CB0, k1, time, dt = dt )

plot(t, ca, xlabel="Time (s)", ylabel="Concentration [X]", grid=false, label = "A")
plot!(t, cb, label = "B")
plot!(framestyle=:box)

CA_exact = similar(t)
@. CA_exact = CA0*exp(-k1*t)

plot!(t,CA_exact,label="Exact", linestyle = :dot, linecolor = :purple)

using Printf

savefig("./sim1/sim1.svg")
file = open("./sim1/sim1.dat","w")
println(file, "\ttime", "\t\t\t", "CA", "\t\t\t\t", "CB")
i = 0
for x in t
    global i = i + 1
    line = @sprintf(" %5.10f  %5.10f  %5.10f ", t[i], ca[i], cb[i])
    println(file, line)
end
close(file)
