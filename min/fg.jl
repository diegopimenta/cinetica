X = [1., 10.]
function f(X)
    return 2*X[1]^3 + X[2]^3
end
function g(X)
    return [6*X[1]^2, 3*X[2]^2]
end


min(X, f, g)
