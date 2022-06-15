import java.util.Scanner; //取得使用者的輸入的數字或字串

public class triangle1 //畫出指定列數的三角型
{
	public static void main(String[] args) 
	{
		Scanner input = new Scanner(System.in);  //Scanner 是一種類別 要 new一個物件出來，讀取使用者在命令列輸入的各種資料型別
		System.out.print("ex:input columnsNo:"); //顯示 ex:input columnsNo:
		int a = input.nextInt(); //取得使用者輸入的整數
		for(int i=1; i<=a; i++) //a=使用者輸入幾層三角形  層數的for迴圈
		{
			for(int j=1; j<=a-i; j++) //根據有幾層三角形 就有幾個x
		    {
				System.out.print("x");
		    }
		    System.out.print(a-i); //顯示有幾層三角形 就有幾個x (減一個)
		    
		    for(int k=1; k<=i*2-1; k++)  //有幾層的三角形 就有幾個星星 
		    {
		    	System.out.print("*");
		    }
		    System.out.print("");
	        System.out.println("(" + (i*2-1) + ")"); //顯示各層星星有幾個
		}
	}
}