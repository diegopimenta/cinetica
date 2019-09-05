CA0 = 10.   # Initial concentration
CB0 = 1.
k1 = 0.1    # Velocity constant
km1 = 0.05
time = 100. # Simulation time
dt = 1.e-2

t, ca, cb = sim2(CA0, CB0, k1, km1, time, dt = dt)


#pyplot(right_margin=1,top_margin=1,framestyle=[:box])
plot(t, ca, xlabel="Time (s)", ylabel="Concentration [X]", grid=false, label = "A")
plot!(t, cb, label = "B")
plot!(framestyle=:box)

savefig("./sim2/sim2.svg")


t1, ca1, cb1 = sim21(CA0, CB0, k1, km1, time, dt = dt)

dif = [similar(ca), similar(cb)]

@. dif[1] = ca1 - ca
@. dif[2] = cb1 - cb

plot(t, dif[1], xlabel="Time (s)", ylabel="Diference", grid=false, framestyle=:box, label = "[A]")
plot!(t, dif[2], xlabel="Time (s)", ylabel="Diference", grid=false, framestyle=:box, label = "[B]")

using Printf

savefig("./sim2/sim2dif.svg")
file = open("./sim2/sim2.dat","w")
println(file, "\ttime", "\t\t\t", "CA", "\t\t\t\t", "CB")
i = 0
for x in t
    global i = i + 1
    line = @sprintf(" %5.10f  %5.10f  %5.10f ", t[i], ca[i], cb[i])
    println(file, line)
end
close(file)
