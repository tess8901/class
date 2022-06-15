
public class multiply { 	//99乘法表

	public static void main(String[] args) {
		
		for(int i = 2 ; i <= 9 ; i++){  //被乘數 從2開始 
			for(int j = 2; j <=9; j++ ){ //乘數 
				System.out.print(i+"*"+j+"="+(i*j)+'\t'); // \t=Tab
			}
			System.out.println(); //到9就換行
		}
	}
}
