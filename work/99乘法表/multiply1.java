
public class multiply1 { 	//99乘法法 額外功課

	public static void main(String[] args) {
		
		for(int i = 2 ; i <= 9 ; i++){   //被乘數
			for(int j = i ; j<=9 ;j++){   //乘數  如果j=7 i=7 就是 7*7=49	7*8=56	7*9=63,如果j=8 i=8  就是 8*8=64 8*9=72 
				System.out.print(i+"*"+j+"="+(i*j)+'\t');
			}
			System.out.println(); //到9就換行
		}
	}
}
