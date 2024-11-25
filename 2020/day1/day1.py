entries = []
with open("input1.txt") as f:
    for line in f:
        entries.append(int(line.strip()))

#part1

for entry in entries:
    if 2020 - entry in entries:
        print(entry * (2020 - entry))

#part2

for e1 in entries:
    for e2 in entries:
        for e3 in entries:
            if e1 + e2 + e3 == 2020:
                print(e1 * e2 * e3)
