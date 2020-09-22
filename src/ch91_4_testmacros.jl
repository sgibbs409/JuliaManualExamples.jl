using Test

@test 1 ≈ 0.999999999999

@test 1 ≈ 0.99999

#           Test.@inferred [AllowedType] f(x)

f(a) = a > 1 ? 1 : 1.0

typeof(f(2))
typeof(f(1))
@code_warntype f(1)
@code_warntype f(2)

@inferred f(2)
@inferred f(1)

@inferred max(1,2)


g(a) = a < 10 ? missing : 1.0

g(2)
g(20)

@inferred g(2)
@inferred g(20)

@inferred Missing g(2)
@inferred Missing g(20)
