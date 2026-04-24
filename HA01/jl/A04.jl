# HIER B

function rm_item(mat::Matrix{T}) where T
    ypos = xpos = 1
    mat[1, 1] = Inf # setzen die richtige Stelle in der Matrix auf \infty
    ysize = size(mat)[1]
    xsize = size(mat)[2]
    while ypos < ysize && xpos < xsize
    # tauschen die aktuelle Position mit der groesseren der beiden Positionen unter oder rechts von der aktuellen
        if mat[ypos + 1, xpos] < mat[ypos, xpos + 1]
            mat[ypos, xpos], mat[ypos + 1, xpos] = mat[ypos + 1, xpos], mat[ypos, xpos]
            ypos += 1
        else
            mat[ypos, xpos], mat[ypos, xpos + 1] = mat[ypos, xpos + 1], mat[ypos, xpos]
            xpos += 1
        end
    end
    while ypos < ysize
        mat[ypos, xpos], mat[ypos + 1, xpos] = mat[ypos + 1, xpos], mat[ypos, xpos]
        ypos += 1
    end
    while xpos < xsize
        mat[ypos, xpos], mat[ypos, xpos + 1] = mat[ypos, xpos + 1], mat[ypos, xpos]
        xpos += 1
    end
    return mat
end

# this is all to test functionality of the function (be impressed)
function generate_matrix(ysize::Int, xsize::Int)
    A = Matrix{Float64}(undef, ysize, xsize)
    A[1, 1] = round(rand(Float64)*5, digits=3)
    for i = 2:ysize
        A[i, 1] = round(A[i - 1, 1] + rand(Float64)*5, digits=3)
    end
    for j = 2:xsize
        A[1, j] = round(A[1, j - 1] + rand(Float64)*5, digits=3)
    end
    for i = 2:ysize
        for j = 2:xsize
            A[i, j] = round(max(A[i - 1, j], A[i, j - 1]) + rand(Float64)*5, digits=3)
        end
    end
    return A
end

function checkYoungness(A::Matrix{T}) where T
    for i = 1:size(A)[1]
        for j = 1:size(A)[2] - 1
            if A[i, j] > A[i, j + 1]
                return false, A
            end
        end
    end
    for i = 1:size(A)[2]
        for j = 1:size(A)[1] - 1
            if A[j, i] > A[j + 1, i]
                return false, A
            end
        end
    end
    return true, A
end

function testrm_item()
    matrixsize = 2:5
    A = generate_matrix(rand(matrixsize), rand(matrixsize))
    rm_column = rand((true, false))
    if rm_column
        rm_item(A)
    else
        rm_item(A)
    end
    return(checkYoungness(A)[1])
end

# end of tests

# HIER C

function insert_item(mat::Matrix{T}, x::T) where T
    ysize = ypos = size(mat)[1]
    xsize = xpos = size(mat)[2]
    mat[ypos, xpos] = x
    while ypos > 1 && xpos > 1 && (mat[ypos - 1, xpos] > x || mat[ypos, xpos - 1] > x)
        if mat[ypos - 1, xpos] > mat[ypos, xpos - 1]
            mat[ypos, xpos], mat[ypos - 1, xpos] = mat[ypos - 1, xpos], mat[ypos, xpos]
            ypos -= 1
        else
            mat[ypos, xpos], mat[ypos, xpos - 1] = mat[ypos, xpos - 1], mat[ypos, xpos]
            xpos -= 1
        end
    end
    while ypos > 1 && mat[ypos - 1, xpos] > x
        mat[ypos, xpos], mat[ypos - 1, xpos] = mat[ypos - 1, xpos], mat[ypos, xpos]
        ypos -= 1
    end
    while xpos > 1 && mat[ypos, xpos - 1] > x
        mat[ypos, xpos], mat[ypos, xpos - 1] = mat[ypos, xpos - 1], mat[ypos, xpos]
        xpos -= 1
    end
end

# so this should reliably test things, it works, so im pretty okay with it :)
for i = 1:20
    matrixsize = 3:7
    ysize = rand(matrixsize)
    xsize = rand(matrixsize)
    mat = generate_matrix(ysize, xsize)
    for removes = 1:ysize*xsize - 9
        rm_item(mat)
        println(checkYoungness(mat)[1])
    end
    println()
    for j = 1:5
        insert_item(mat, round(rand(Float64)*5, digits=3))
        println(checkYoungness(mat)[1])
    end
end