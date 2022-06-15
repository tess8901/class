#輸入身高(公尺) 體重(公斤)(皆使用小數)
#BMI = 體重(公斤) / (身高*身高)(公尺)
#結果須輸出到小數點第一位
#print("%.1f" %x1);

#height身高 weight體重
height1 = float(input())
weight1 = float(input())

#BMI = 體重/(身高*身高)
BMI1 = weight1/(height1*height1)

#顯示到小數第一位
print("%.1f" %BMI1)