import util

inp = util.load("input3.txt")

# p1
offset = 0
count = 0
for line in inp:
    if offset != 0:
        if line[offset % len(line)] == "#":
            count += 1
    offset += 3
print(count)

# p2


def test(r, d):
    offset = 0
    count = 0
    for idx,line in enumerate(inp):
        if idx % d == 0:
            if offset != 0:
                if line[offset % len(line)] == "#":
                    count += 1
            offset += r
    return count
    
print(test(3,1) * test(1,1) * test(5,1) * test(7,1) * test(1,2))