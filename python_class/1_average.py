#某一學生修國文Chinese、計算機概論CS、計算機程式設計PD三科，使用者輸入名字（一個string）、學號（int）、三科成績(int)。
#(1) 計算學生總成績、平均。
#(2) 印出名字、學號、總成績、平均。
#(3) 輸出的數字如為整數，不需含有小數點。

#name 姓名 sid 學生學號 cs 計算機概論 pd計算機程式設計
Name = input()
Sid = int(input())
Chinese = int(input())
CS = int(input())
PD = int(input())

#ScoreSum總成績
ScoreSum = Chinese+CS+PD
#平均
AverageScore = ScoreSum//3

print('Name:',end='')
print(Name)
print('ID:',end='')
print(Sid)
print('Average:',end='')
print(AverageScore)
print('Total:',end='')
print(ScoreSum)
