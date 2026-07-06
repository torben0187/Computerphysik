import Pkg; Pkg.add("Symbolics")

using Symbolics, LinearAlgebra, Plots

# --- Funktion symbolisch definieren ---
@variables x y
f_sym = x^2 * y * (x - y + 1)

# Gradient und Hesse-Matrix
grad = Symbolics.gradient(f_sym, [x, y])
hess = Symbolics.hessian(f_sym, [x, y])

# --- Kritische Punkte lösen (Gradient = 0) ---
# Für dieses Polynom lässt sich das analytisch bestimmen:
# f_x = x(3xy - 2y^2 + 2y) = 0
# f_y = x^2(x - 2y + 1) = 0
# Lösungen: x = 0 (ganze Linie!), sowie (-1, 0) und (-1/2, 1/4)

critical_points = [(-1.0, 0.0), (-0.5, 0.25), (0.0, 0.0), (0.0, 1.0), (0.0, -1.0)]

f_num(x, y) = x^2 * y * (x - y + 1)

f_x(x,y) = 3x^2*y - 2x*y^2 + 2x*y
f_y(x,y) = x^3 - 2x^2*y + x^2

H(x,y) = [6x*y-2y^2+2y   3x^2-4x*y+2x;
          3x^2-4x*y+2x   -2x^2]

function classify(x, y)
    Hm = H(x, y)
    ev = eigvals(Hm)
    if all(ev .> 1e-8)
        return :min
    elseif all(ev .< -1e-8)
        return :max
    elseif any(ev .> 1e-8) && any(ev .< -1e-8)
        return :saddle
    else
        return :degenerate   # z.B. entlang der Linie x=0
    end
end

# --- Plot vorbereiten ---
xs = range(-2, 2,