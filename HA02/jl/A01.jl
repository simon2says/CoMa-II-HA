# A HERE

function Catalan2(n::Int)::Int
    cataList = zeros(n + 1)
    cataList[1] = 1 # wir setzen den ersten Eintrag in der Liste
    for i = 1:n # Da Listen in Julia 0-indexed sind, nicht wie bei den Catalanzahlen auf 0, machen wir ein paar Anpassungen, wie, dass wir alle Indexes um 1 verschieben.
        for j = 0:i-1
            cataList[i + 1] += cataList[j + 1] * cataList[i - j]
        end
    end
    return cataList[n + 1]
end

# B HERE

# Zunaechst dispatchen wir die Addition fuer die beiden Optionen, in denen eins der beiden Argumente ein Nothing ist. Realistisch kann fuer uns natuerlich nur das erste Argument ein Nothing sein.

function Base.:+(a::Nothing, b::Real)::Real
    return b
end

function Base.:+(a::Real, b::Nothing)::Real
    return a
end

function CatalanTriangle(n::Int)::Int
    mat = Matrix{Union{Int64, Nothing}}(nothing,n,n) # wir generieren eine leere Matrix
    mat[1, 1] = 1
    for i = 2:n
        for j = 1:i
            if j == 1
                mat[i, j] = 1
            else
                mat[i, j] = mat[i - 1, j] + mat[i, j - 1] # der regulaere Berechnungsweg fuer das Catalan-Dreieck
            end
            if i >= 3
                mat[i - 2, j] = nothing # wir setzen alle Eintraege der darueberstehenden Zeilen auf nothing, um Speicherplatz wie in der Aufgabenstellung angegeben einzusparen.
            end
            println(mat)
        end
    end
    return mat[n, n]
end