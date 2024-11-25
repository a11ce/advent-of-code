def loadProg():
    prog = []
    with open("input8.txt") as f:
        for line in f:
            line = line.strip()
            prog.append([line[:3], int(line[4:])])
    return prog


def runProg(prog):
    pcHist = []
    pc = 0
    acc = 0
    while pc not in pcHist:
        pcHist.append(pc)
        opC, arg = prog[pc]

        if opC == "acc":
            acc += arg
            pc += 1

        elif opC == "jmp":
            pc += arg

        elif opC == "nop":
            pc += 1
    return acc


def main():
    inProg = loadProg()
    print(runProg(inProg))


if __name__ == "__main__":
    main()
