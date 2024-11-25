import util

inp = util.load("input2.txt")

# p1
count = 0
for line in inp:
    tarr = line.strip().split(" ")
    char = tarr[1][0]
    vals = [int(x) for x in tarr[0].split("-")]
    #print(vals)
    if vals[0] <= tarr[2].count(char) <= vals[1]:
        count += 1

print(count)

#p2

c2 = 0
for line in inp:
    tarr = line.strip().split(" ")
    char = tarr[1][0]
    vals = [int(x) - 1 for x in tarr[0].split("-")]
    if (tarr[2][vals[0]] == char) != (tarr[2][vals[1]] == char):
        c2 += 1
print(c2)