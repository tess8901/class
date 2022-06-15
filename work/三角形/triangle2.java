
public class triangle2 {

	public static void main(String[] args) {
	  int a=5;
      for(int i=1; i<=a; i++)
      {
//    	  System.out.print();
             for(int j=1; j<=a-i; j++)
             {
                  System.out.print("x");
             }
             System.out.print(a-i);
             for(int k=1; k<=i*2-1; k++)
             {
                  System.out.print("*");
             }
             System.out.print("");
             System.out.println("(" + (i*2-1) + ")");
        }
	}

}
