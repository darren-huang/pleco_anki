tag_search = "级词汇表"
wordlist_file = open("wordlist.txt", "r")
write_file = open("formatted_wordlist.txt", "w")

tags = [1, 2, 3, 4, 5, 6, "7-9"]
tag_index = 0

def process_char(string, char):
    if char in string:
        return string[:string.find(char)]
    return string
    

for line in wordlist_file:
    line = line.strip()
    if line:
        if tag_search in line:
            write_file.write("hsk_level_" + str(tags[tag_index]) + "\n")
            tag_index += 1
        else:
            line = process_char(line, "|")
            line = process_char(line, "(")
            line = line.strip().split()[1]
            write_file.write(line + "\n")


