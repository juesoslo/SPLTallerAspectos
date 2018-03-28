package aspectos;

import java.lang.reflect.Array;
import java.lang.reflect.Field;
import java.lang.reflect.Method;

import uniandes.cupi2.impuestosCarro.mundo.Vehiculo;

public aspect AddCars {
	pointcut addCars(): initialization(uniandes.cupi2.impuestosCarro.mundo.CalculadorImpuestos.new());
	
	after() throws Exception: addCars(){
		//Cargando el campo "Vehiculos"
		Field fieldVehiculos = thisJoinPoint.getThis().getClass().getDeclaredField("vehiculos");
		fieldVehiculos.setAccessible(true); //El campo es privado. Se hace accesible.

		//La lista de vehiculos cargados en la clase
        Vehiculo[] vehiculos = (Vehiculo[]) fieldVehiculos.get(thisJoinPoint.getThis());
        System.out.println("----------------------------------------------------------");
        System.out.println("Cargados "+vehiculos.length +" vehiculos en el primer archivo");
        
        
        //Cargando el metodo "cargarVehiculos"
        Method method = thisJoinPoint.getThis().getClass().getDeclaredMethod("cargarVehiculos", new Class[] { String.class });
        method.setAccessible(true); //El método es privado. Se hace accesible.
        
        //Se ejecuta el método con el nuevo archivo de texto
        method.invoke(thisJoinPoint.getThis(), "data/vehiculos2.txt");
        
        
        //La nueva lista de vehiculos cargados en la clase
        Vehiculo[] vehiculos2 = (Vehiculo[]) fieldVehiculos.get(thisJoinPoint.getThis());
        System.out.println("----------------------------------------------------------");
        System.out.println("Cargados "+vehiculos2.length +" vehiculos en el segundo archivo");
        
        
        //Uniendo las dos listas en un sólo array
        int aLen = vehiculos.length ;
        int bLen = vehiculos2.length;

        @SuppressWarnings("unchecked")
        Vehiculo[] vehiculosUnidos = (Vehiculo[]) Array.newInstance(vehiculos.getClass().getComponentType(), aLen + bLen);
        System.arraycopy(vehiculos, 0, vehiculosUnidos, 0, aLen);
        System.arraycopy(vehiculos2, 0, vehiculosUnidos, aLen, bLen);
        
        
        //La lista de vehiculos cargados en la clase
        fieldVehiculos.set(thisJoinPoint.getThis(), vehiculosUnidos);
        System.out.println("----------------------------------------------------------");
        System.out.println("Unidos "+vehiculosUnidos.length +" vehiculos");
	}
}
