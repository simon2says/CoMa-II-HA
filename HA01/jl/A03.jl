function catalan(n::Int)
    if n == 0
        return 1
    end
    sum = 0
    for i in 0:n - 1
        sum += catalan(i) * catalan(n - 1 - i)
    end
    return sum
end