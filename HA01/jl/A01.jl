mutable struct Stack{T}
    data::Vector{T}
end

isEmpty(Q::Stack) = Q.data == []
insert(Q::Stack{T}, x::T) where T = push!(Q.data, x)
pop(Q::Stack) = pop!(Q.data)
peek(Q::Stack) = last(Q.data)

mutable struct Queue{T}
    inputstack::Stack{T}
    outputstack::Stack{T}
end

function isEmpty(Q::Queue)
    return isEmpty(Q.inputstack) && isEmpty(Q.outputstack)
end

function queue_insert(Q::Queue{T}, x::T) where T
    insert(Q.inputstack, x)
end

function queue_pop(Q::Queue)
    if isEmpty(Q.outputstack)
        while !isEmpty(Q.inputstack)
            insert(Q.outputstack, pop(Q.inputstack))
        end
        return pop(Q.outputstack)
    end
end