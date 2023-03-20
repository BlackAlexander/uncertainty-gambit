if __name__ == '__main__':
    f = open("input.txt", "r")
    baseString = f.read()
    for i in range(1, 15):
        finalString = ""
        for character in baseString:
            if character == "P":
                finalString += str(i)
            else:
                finalString += character
        print(finalString + "\n")
