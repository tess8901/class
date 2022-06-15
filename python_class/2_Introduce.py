#一元二次方程式，ax^2 + bx + c = 0，輸入a, b, c, 求 方程式的兩個實根。

#匯入 math函式庫
import math
#輸入三個數
a = int(input())
b = int(input())
c = int(input())

x1 = ((-b)+math.sqrt(b*b-4*a*c))/(2*a)
x2 = ((-b)-math.sqrt(b*b-4*a*c))/(2*a)

print("%.1f" %x1)
print("%.1f" %x2)
