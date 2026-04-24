function iterative_treewalk(node::Node)::Nothing
    s = Vector{Node}()
    curr = node
    while !isempty(s) || (!isnothing(curr.left) || !isnothing(curr.right))
        if !isnothing(curr.left)
            push!(s, curr)
            curr = curr.left
        elseif !isnothing(curr.right)
            println(curr)
            curr = curr.right
        else
            println(curr)
            curr = pop!(s)
            println(curr)
            curr = curr.right
        end
    end
    println(curr)
end