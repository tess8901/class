

public class Customer {
	
	public String maskName(String cusName){  //未隱碼
		String name = "";  //隱碼
		
		// 取得顧客姓名的長度
		int cusLength = cusName.length();
		
		// 判斷式
		// 1.若顧客姓名為兩個字則隱碼第二個字
		if(cusLength <= 2)
		{  
			System.out.println("兩個字: " +cusName);
			name = cusName.replace(cusName.substring(1),"X");
			
		} 
		
        // 2.若為三個字則隱碼第二個字
		else if(cusLength == 3) 
		{  
			System.out.println("三個字: " +name);
			name = cusName.replace(cusName.substring(1,2),"X");
		} 
		
        // 3.若為四個字則隱碼第二、第三個字
		else if(cusLength == 4) 
		{  
			System.out.println("四個字: " + name);
			name = cusName.replace(cusName.substring(1,3),"XX");
			
		} 
		
		// 4.若為四個字以上則一律隱碼第二、第三個字
		else if(cusLength > 4) 
		{  
			String start = cusName.substring(0,1); // 只顯示第一個字
			String end = cusName.substring(3, 5); //只顯示最後兩個字
			name = start + "XX" + end;
			System.out.println("四個字以上: ");
			
		}
		
		
		
		// 姓名隱碼指定的位置
		
		
		
		return name;
	}
	
	
}
