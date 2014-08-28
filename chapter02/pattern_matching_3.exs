a = 2
[a,b,a] = [1,2,3] # no match
[a,b,a] = [1,1,2] # no match
a = 1             # match
^a = 2            # no match
^a = 1            # match
^a = 2 - a        # match
