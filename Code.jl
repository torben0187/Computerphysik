using LinearAlgebra








function pseudo_inverse_with_trunc(A,tol=1e-15)

    U, sigma, V = svd(A)
    idx = findfirst(x -> x <= 1e-15, sigma)
    sigma[idx:end] .= 0
    S = Diagonal(simga)
    pseudo_inv = V * inv(S) * U'
    return pseudo_inv
end