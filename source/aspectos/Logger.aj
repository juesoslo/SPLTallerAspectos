package aspectos;

public aspect Logger{
	pointcut logger(): within(uniandes.cupi2.impuestosCarro.mundo..*)
		&& call(public * * (..));
	
	before(): logger(){
		System.out.println("----------------------------------------------------------");
		System.out.println("M�todo: " +thisJoinPointStaticPart.getSignature());
		System.out.println("- Par�metros: " +thisJoinPoint.getArgs());
		System.out.println("- Objeto sobre el que se invoca: " +thisJoinPoint.getTarget());
	}
	
	after() returning(Object r): logger(){
		System.out.println("- Resultado de: " +thisJoinPointStaticPart.getSignature());
		System.out.println("- " + (r==null?null:r.toString()) );
	}
	
	after() throwing(Throwable e): logger(){
		System.out.println("- Excepci�n en: " +thisJoinPointStaticPart.getSignature());
		System.out.println("- " +(e==null?null:e.toString()));
	}
}
