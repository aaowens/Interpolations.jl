
module Linear1DTests
println("Testing Linear interpolation in 1D...")
using Interpolations, Base.Test

f(x) = sin((x-3)*2pi/9 - 1)
xmax = 10

A = Float64[f(x) for x in 1:xmax]

## ExtrapError

itp1 = Interpolation(A, Linear(OnGrid()), ExtrapError())

for x in [3.1:.2:4.3]  
    @test_approx_eq_eps f(x) itp1[x] abs(.1*f(x))
end

@test_throws BoundsError itp1[-3]


## ExtrapNaN

itp2 = Interpolation(A, Linear(OnGrid()), ExtrapNaN())

for x in [3.1:.2:4.3]  
    @test_approx_eq_eps f(x) itp1[x] abs(.1*f(x))
end

xlo, xhi = itp2[.9], itp2[xmax+.2]
@test isnan(xlo)
@test isnan(xhi)

end

module Linear2DTests
println("Testing Linear interpolation in 2D...")
using Interpolations, Base.Test

f(x,y) = sin(x/10)*cos(y/6)

xmax, ymax = 30,10

A = [f(x,y) for x in 1:xmax, y in 1:ymax]

itp1 = Interpolation(A, Linear(OnGrid()), ExtrapError())

for x in 1.1:.2:xmax-.1, y in 1.1:.2:ymax
    @test_approx_eq_eps f(x,y) itp1[x,y] .1
end

end