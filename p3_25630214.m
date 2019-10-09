clear all
close all

%cargo los datos en un struct data para que quede contenido alli la info externa y accedere
%luego con algo como data.x
data=load ("practica3.mat");

%1. Estimación de las entradas: con los datos suministrados, compute las distancias
%entre el target y cada una de las anclas. Considere que la velocidad de propagación
%del sonido es c = 340 m/s.

sound_speed=340;
distance=(data.times_tx-data.times_rx)*sound_speed;

%2. Estimación de la posición: Implemente el algoritmo de trilateración. Para ello
%primero defina las matrices y vectores para resolver la posición mediante la
%aproximación de cuadrados mínimos. Recuerde que el algoritmo utiliza una de las
%anclas como referencia relativa (elija arbitrariamente cualquiera de ellas). Luego, la
%solución del sistema debe corregirse con las coordenadas de esa ancla para
%recuperar la posición absoluta del target. Repita el algoritmo para cada medición y
%guarde los resultados en una matriz P de posiciones (matriz cuyas filas deben ser
%las posiciones estimadas y sus columnas las coordenadas x e y de cada posición).

%solucion:
%elijo el ancla de referencia, puede ser cualquiera (1 a 6 para este caso)

ref=3;

%genero la matriz ri_ref que se define como

r=(data.AP-data.AP(ref,:)).^2;
r=(r(:,1)+r(:,2)).^.5;           %calculo la raiz pero luego la uso siempre al cuadrado..
                                 %podria evitarse esta cuenta.. lo dejo para que se entienda
                                 %pero no haria falta
r=r';                            %me conviene en forma de fila,queda mas claro en el codigo luego


%genero la matriz bi1 notar que el b(i,ref) quedara todo en cero, pero sera una ecuacion que no
%participara en las cuentas porque la igualdad quedara 0=0. Se puede eliminar complicando un
%poco la codificacino pero no se gana demasiado en procesamiento asi que se decide dejarla 
%tambien se podria evitar el r.^2 si no se calcula la raiz en la oeracion anterior..

b=1/2*(distance(:,ref).^2-distance.^2+r.^2);

%genero la matriz A como
A=data.AP-data.AP(ref,:);  %aca tambien quedara la entrada A(ref,:) todo cero y por eso cuando
                           %se multiplique por la b queda una ecuacion del tipo 0=0 que no
                           %participa en el calculo de posicion

%calculo la matriz x
x = ((inv(A' * A) * A') * b')';    %b traspuesta porque la defini como vectores filas y luego
                                   %traspongo todo para que vuelva a quedar todo en filas x,y

%calculo la posicion sumando la referencia elegida
P = x + data.AP(ref,:);

%3. Utilizando la función plotloc(P, AP) grafique los resultados de la estimación de
%las posiciones del target. Luego, cuando considere que su algoritmo funciona
%adecuadamente, guarde los resultados en un archivo .csv mediante el siguiente
%comando en octave: csvwrite(‘resultados_DNI.csv’, P) , donde “DNI” debe
%ser su número de documento. Finalmente en la zona de Files de Octave, seleccione
%el archivo “.csv” y descárguelo

%grafico los puntos
plotloc(P,data.AP,data.plano);   %ploteo los puntos usando la funcion plotloc

%guardo los datos en un archivo como se solicito
csvwrite("resultados_25630214.csv", P)
