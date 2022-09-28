package util;

import java.util.Calendar;

public class ChangeName {
	
	public static String getChangeFileName(String fileName)
	{
		//.�� ��ġ
		int dotLoc=fileName.indexOf('.');
		System.out.println(dotLoc);
		String fname=fileName.substring(0,dotLoc); //���ϸ�(�����ٶ󸶹ٻ�)
		String ext=fileName.substring(dotLoc); //Ȯ����(.jpg)
		
		//��¥�� ���ؼ� ����Ͻú���+õ����1.jpg �̷������� ���ϸ� �����ϱ�
		Calendar cal=Calendar.getInstance();
		int y=cal.get(Calendar.YEAR);
		int m=cal.get(Calendar.MONTH)+1;
		int d=cal.get(Calendar.DATE);
		int hh=cal.get(Calendar.HOUR);
		int mm=cal.get(Calendar.MINUTE);
		int ss=cal.get(Calendar.SECOND);
		int ms=cal.get(Calendar.MILLISECOND);
		
		//���ڰ���� �������� �Ǿ��� ""�� ���ڿ� ó��
		fileName=""+y+(m<10?"0"+m:m)+(d<10?"0"+d:d)+(hh<10?"0"+hh:hh)+(mm<10?"0"+mm:mm)
				+(ss<10?"0"+ss:ss)+ms+ext;
		
		return fileName;
	}

}
