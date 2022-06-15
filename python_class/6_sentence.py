#1. 輸入兩個英文句子 A, B，兩個英文單字 x, y
#將兩個英文句子A, B 串聯成 句子C
#2. 將 句子C 其中的 單字x 取代成 單字y，變成 句子D
#3. 輸出 句子C, 句子D 長度的加總
#4. 把句子D 前三個字以及最後三個字組合成 句子E，把 句子E重複輸出三次。

# Input：
# This is a book
# That is a cat
# is
# was

# Output：
# 57
# ThwcatThwcatThwcat

sentenceA = input()
sentenceB = input()

wordX = input()
wordY = input()

sentenceC = sentenceA + " " + sentenceB

print(sentenceC)
print(len(sentenceC))


# sentence1 = "this is a book"
# print(len(sentence1))

# sentence2 = "That is a cat"
# print(len(sentence2))


# sentence3 = "ThwcatThwcatThwcat"
# print(len(sentence3))
