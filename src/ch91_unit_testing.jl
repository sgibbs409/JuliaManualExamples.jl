using Test


#=
    91.2    Basic Unit Tests
=#

foo(x) = length(x)^2

@test foo("hey") == 9
@test foo("there") > 20

@test_throws BoundsError [1,2,3][4]

@test_throws DimensionMismatch [1,2,3] + [1,2]

# @test_throws BoundsError [1,2,3][3]
@test π ≈ 3.14 atol=0.01

result = @test ≈(π, 3.14, atol=0.01)

@show result.test_type
@show result
@show result.value
@show result.orig_expr
@show typeof(result.orig_expr)
@show result.data

# This throws exception MethodError
# @test foo(:cat) == 1
@test_throws MethodError foo(:cat)


#=
    91.3    Working With Test Sets
=#

result = @testset "My Description of this test set" begin
    @test foo("hello") == 25
    @test foo("bar") == 9
end

@show result
@show result.description
@show result.results
@show result.n_passed
@show result.anynonpass



# r = @test_throws TestSetException begin
#         @testset "My Description of this test set" begin
#             @test foo("hello") == 25
#             @test foo("bar") == 9
#             @test foo("bars") == 9
#         end
# end;
# @show r


try
    @testset "My new testset description" begin
        @test foo("hello") == 25
        @test foo("bar") == 9
        @test foo("bars") == 16
    end
catch e
    println(e);
    #rethrow(e)
    nothing
finally
    println("Finally!")
    nothing
end

# Nested testsets

result = @testset "Foo Tests" begin
    @testset "Animals" begin
        @test foo("cat") == 9
        @test foo("dog") == foo("cat")
    end
    @testset "Arrays $i" for i in 1:3
        @test foo(zeros(i)) == i^2
        @test foo(fill(1.0, i)) == i^2
    end
end;

@show result;

@show result.description

for (i,r) in enumerate(result.results)
    println(i, ": ", r)
end

@show result.anynonpass




@testset "Foo Tests" begin
    @testset "Animals" begin
        @testset "Felines" begin
            @test foo("cat") == 9
        end
        @testset "Canines" begin
            @test foo("dog") == 9
        end
    end
    @testset "Arrays" begin
        @test foo(zeros(2)) == 4
        @test foo(fill(1.0, 4)) == 16
    end
end
