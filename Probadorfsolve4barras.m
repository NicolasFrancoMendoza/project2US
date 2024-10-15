clc
clear
close all

%Variables
a=1; %Manivela
b=2.06; %Acoplador
c=2.33; %Salida
d=2.22; %Piso
T1 = 0; %Inclinación suelo

%Desplazamiento del mecanismo en X y Y
Dx = 0;
Dy = 0;
    
v = VideoWriter('mecanismo.avi'); %Creación de la animación
open(v);

in = 30; %Ángulo inicial del análisis
fin = in+360; %Ángulo final del análisis
options = optimoptions('fsolve','Display','off');

for i = in:fin
    %Solucionar ecuación
    T2 = i;
    C = [a b c d T1 T2];
    
    fun = @(x) fFourBarLinkage(x,C);

    x0 = [50,90]; %Condiciones iniciales, T3, T4
    [x,fval,exitFlag] = fsolve(fun,x0,options);

    if exitFlag > 0

        %Posiciones vectores
        x1 = 0+Dx; y1 = 0+Dy; x4 = d*cosd(T1)+Dx; y4 = d*sind(T1)+Dy; %Pivotes desplazados Dx y Dy
        x2 = a*cosd(T2+T1)+Dx; y2 = a*sind(T2+T1)+Dy;
        x3sr = x2+b*cosd(x(1)); y3sr = y2+b*sind(x(1)); %Variables sin ser rotadas
        x3 = x3sr*cosd(T1)-y3sr*sind(T1); y3 = y3sr*cosd(T1)+x3sr*sind(T1);

        plot([-2 5],[-2 5], 'w') %Tamaño de la impresión de pantalla
        hold on
        plot([x1 x2],[y1 y2], 'r') %Gráfica de los eslabones
        hold on
        plot([x2 x3],[y2 y3], 'b')
        hold on
        plot([x3 x4],[y3 y4], 'r')

        Ra = sqrt((x1-x2)^2+(y1-y2)^2);
        Rb = sqrt((x2-x3)^2+(y2-y3)^2);
        Rc = sqrt((x3-x4)^2+(y3-y4)^2);

    else
        error('La mondá no se solucionó')
    end

    frame = getframe;
    writeVideo(v,frame);
    clf('reset');

end

close(v);