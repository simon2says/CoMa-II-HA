def findMinMax(A):
    """
        Finds the minimum and the maximum elements of a list.
        Args:
            A (list of int): The list to be searched for the maximum and minimum.
        Returns:
            (int): The maximum of that list
            (int): The minimum of that list.
        Implementation:
            First, divides the list into two sublists, called the minlist and the maxlist by looking over two elements at once and comparing them. The larger element goes into the maxlist, the smaller element into the minlist. Then, we iterate over both lists to find the maximum and the minimum respectively.
    """
    maxlist = []
    minlist = []
    n = len(A)
    for i in range(n//2):
        if A[i*2] > A[i*2+1]:
            maxlist.append(A[i*2])
            minlist.append(A[i*2+1])
        else:
            maxlist.append(A[i*2+1])
            minlist.append(A[i*2])
    if n % 2 == 1:
        minlist.append(A[-1])
        maxlist.append(A[-1])
    minimum = minlist[0]
    maximum = maxlist[0]
    for el in minlist:
        if el < minimum:
            minimum = el
    for el in maxlist:
        if el > maximum:
            maximum = el
    return minimum, maximum