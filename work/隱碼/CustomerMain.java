
public class CustomerMain {
	public static void main(String[] args) {
	//	String cusName = "";
		
		Customer customer = new Customer();
		
		String n1 = "趙雲";
		String n1Mask = customer.maskName(n1);
		System.out.println(n1Mask);
		
		String n2 = "馬小九";
		String n2Mask = customer.maskName(n2);
		System.out.println(n2Mask);
		
		String n3 = "司馬中承";
		String n3Mask = customer.maskName(n3);
		System.out.println(n3Mask);
		
		String n4 = "常山趙子龍";
		String n4Mask = customer.maskName(n4);
		System.out.println(n4Mask);
		
		
		
//		String name = customer.maskName(cusName);
		
//		System.out.println(customer.maskName("趙雲"));
//		System.out.println(customer.maskName("趙子龍"));
//		System.out.println(customer.maskName("司馬中承"));
//		System.out.println(customer.maskName("常山趙子龍"));

	}

}
