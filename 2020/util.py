def load(fileName):
    lines = []
    with open(fileName) as f:
        for line in f:
            lines.append(line.strip())
    return lines