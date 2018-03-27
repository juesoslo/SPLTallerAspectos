package aspectos;

public aspect Mailer {
	pointcut mailer(): within(uniandes.cupi2.impuestosCarro.interfaz..*)
		&& call(public * * (..));
	
	before(): mailer(){
		if(thisJoinPointStaticPart.getSignature().toString().equals("void javax.swing.JOptionPane.showMessageDialog(Component, Object, String, int)"))
		{
			String texto = thisJoinPoint.getArgs()!=null?thisJoinPoint.getArgs()[1].toString():"";
			texto = texto.replace("El valor a pagar es: $ ", "");
			texto = texto.replace(".", "");
			int numero = Integer.parseInt(texto);
			
			if( numero > 2000000 )
			{
				System.out.println("----------------------------------------------------------");
				System.out.println("Mailer: Debe enviar un correo electrónico porque los impuestos son: " +numero);
			}
		}
	}
}
