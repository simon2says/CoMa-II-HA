# B HERE

function DeleteNext(L, x)
    if x == L.y || x.next == L.y
        return
    end
    x.next = x.next.next
end

# C HERE

function Insert(L, x)
    x.next = L.head
    L.head = x
    L.y.next = L.head
end

# D HERE

function DeleteNext(L, x)
    x.next = x.next.next
end

# E HERE

function Truncate(L, d)
    curr = L.head
    while curr.data != d && curr.next != L.w
        curr = curr.next
    end
    curr.next = L.w
end