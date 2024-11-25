def numOfPass(bp):
    return (row(bp[:7]) * 8) + col(bp[-3:])


def row(r):
    return bsp(r, 127, "F", "B")


def col(c):
    return bsp(c, 7, "L", "R")


def bsp(inS, startMax, lC, uC):
    mi = 0
    ma = startMax
    for c in inS[:-1]:
        mid = int(mi + ((ma - mi) / 2))
        if c == lC:
            ma = mid
        if c == uC:
            mi = mid + 1
    return mi if inS[-1] == lC else ma


def main():
    with open("input5.txt") as f:
        passes = [p.strip() for p in f]

    IDs = [numOfPass(p) for p in passes]
    print(max(IDs))

    #print(list(IDs))
    for p in list(IDs):
        #print(p)
        if (p + 1 not in IDs) and (p + 2 in IDs):
            print(p + 1)


if __name__ == "__main__":
    main()
