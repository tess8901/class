
public class triangle {

	public static void main(String[] args) {
		
		//上半部
		for(int i=1; i<=5; i++){  //有幾層三角形  假如是5層 1 2 3 4 5
			for(int j=1;j<=i; j++){  //星星個數   5層就5顆星星 1 12 123 1234 12345
				System.out.print("*");
			}
			System.out.println("("+i+")"); //顯示各層星星個數
		}
		
		//下半部
		for(int k=1; k<=4; k++){  //要他的下半部 所以從4層開始 1 2 3 4
			for(int l=4; l>=k; l--){  //星星從第一層4顆開始 每層減1顆
				System.out.print("*");	
			}
			System.out.println("(" + (5-k) + ")"); //顯示每層減1顆星星 4 3 2 1
		}
	}
}
