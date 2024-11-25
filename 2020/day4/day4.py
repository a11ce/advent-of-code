import string
REQUIRED = ["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"]
EYE_COLORS = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]


def loadPassports():
    passports = []
    with open("input4.txt") as f:
        curPass = {}

        for line in f:
            line = line.strip()

            if line == "":
                passports.append(curPass)
                curPass = {}

            else:
                for field in line.split(" "):
                    kV = field.split(":")
                    curPass[kV[0]] = kV[1]

        passports.append(curPass)
    return passports


def hasReq(passport):
    for req in REQUIRED:
        if req not in passport:
            return False
    return True


def validHeight(hgt):
    return any([(hgt[-2:] == "cm" and (150 <= int(hgt[:-2]) <= 193)),
                (hgt[-2:] == "in" and (59 <= int(hgt[:-2]) <= 76))])


def valid(passport):
    return all([
        1920 <= int(passport["byr"]) <= 2002,
        2010 <= int(passport["iyr"]) <= 2020,
        2020 <= int(passport["eyr"]) <= 2030,
        # height
        validHeight(passport["hgt"]),
        # hair col
        passport["hcl"][0] == "#" and len(passport["hcl"]) == 7
        and (all(c in string.hexdigits for c in passport["hcl"][1:])),
        # eye col
        passport["ecl"] in EYE_COLORS,
        # pid
        len(passport["pid"]) == 9
    ])


def main():
    allPass = loadPassports()
    reqd = list(filter(hasReq, allPass))
    print(len(reqd))
    print(len(list(filter(valid, reqd))))


if __name__ == "__main__":
    main()
