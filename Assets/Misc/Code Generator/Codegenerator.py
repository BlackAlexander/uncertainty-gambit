if __name__ == '__main__':
    f = open("input.txt", "r")
    baseString = f.read()
    odds = ["0:0", "6:5", "7:9", "1:3", "3:7", "2:1", "1:19", "2:3", "1:2", "3:2", "5:7", "4:3", "8:3", "3:7", "2:11"]
    for i in range(1, 15):
        finalString = ""
        for character in baseString:
            if character == "P":
                finalString += str(i)
            elif character == "O":
                finalString += odds[i]
            else:
                finalString += character
        print(finalString + "\n")
