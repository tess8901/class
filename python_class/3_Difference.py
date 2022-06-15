#分別輸入 num1 num2 求出兩數的 Sum,Difference,Product,Quotient。
#結果須輸出到小數點第二位
#print("%.2f" %x1);

#num1 num2 兩數
num1 = int(input())
num2 = int(input())

Difference = abs(num1-num2)
#sum 加
Sum = num1+num2
#Quotient 除
Quotient = num1/num2
#Product 乘
Product = num1*num2

print('Difference:',end='')
print("%.2f" %Difference)
print('Sum:',end='')
print("%.2f" %Sum)
print('Quotient:',end='')
print("%.2f" %Quotient)
print('Product:',end='')
print("%.2f" %Product)
