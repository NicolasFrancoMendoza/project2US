clc
clear
close all

%Variables
a=1; %Manivela
b=2.5; %Acoplador
c=2.5; %Salida
d=2; %Piso
T1=0; %聲gulo del piso

%Varibles para el acoplador
T5=deg2rad(0);
e=5;

i=1;
f=360;
% p=zeros(f,2);

v = VideoWriter('mecanismo1.avi'); %Creaci鏮 de la animaci鏮
open(v);

for t=i:f
    T2=deg2rad(t);

    %Variables
    k1=d/a;
    k2=d/c;
    k3=((a^2)-(b^2)+(c^2)+(d^2))/(2*a*c);
    k4=d/b;
    k5=((c^2)-(d^2)-(a^2)-(b^2))/(2*a*b);
    A=cos(T2)-k1-(k2*cos(T2))+k3;
    B=-2*sin(T2);
    C=k1-((k2+1)*cos(T2))+k3;
    D=cos(T2)-k1+(k4*cos(T2))+k5;
    F=k1+((k4-1)*cos(T2))+k5;

    %Discriminantes para saber si existen imaginarios en los 嫕gulos sacados.
    %Mecanismos de NO Grashof
    disc1=(B^2)-(4*A*C); %Discriminante 1
    disc2=(B^2)-(4*D*F); %Discriminante 2

    if disc1>=0 && disc2>=0
        %聲gulos solicitados
        T41=2*atan((-B+sqrt((B^2)-(4*A*C)))/(2*A)); %聲gulo para mecanismo cruzado
        T42=2*atan((-B-sqrt((B^2)-(4*A*C)))/(2*A)); %聲gulo para mecanismo abierto

        T31=2*atan((-B+sqrt((B^2)-(4*D*F)))/(2*D)); %聲gulo para mecanismo cruzado
        T32=2*atan((-B-sqrt((B^2)-(4*D*F)))/(2*D)); %聲gulo para mecanismo abierto

        Z=T32; %聲gulo con el que se desea trabajar
        %Posiciones vectores
        x1=0; y1=0; x4=d; y4=0;
        x2=a*cos(T2); y2=a*sin(T2);
        x3=x2+b*cos(Z); y3=y2+b*sin(Z);
        xn=x2+e*cos(T5+Z); yn=y2+e*sin(T5+Z);

        plot([-2 5],[-2 5], 'w'); %Tama隳 de la impresi鏮 de pantalla
        hold on
        plot([x1 x2],[y1 y2], 'r'); %Gr塻ica de los eslabones
        hold on
        plot([x2 x3],[y2 y3], 'b');
        hold on
        plot([x3 x4],[y3 y4], 'r');

        %Acoplador y Punto P
        hold on
        plot([x2 xn],[y2 yn], 'b')
        hold on
        plot([xn x3],[yn y3], 'b')

        p(t,1)=xn;
        p(t,2)=yn;
        plot(p(:,1),p(:,2),'g')
        frame = getframe;
        writeVideo(v,frame);
        clf('reset');
    end

end
% figure
% plot(p(:,1),p(:,2)) %Gr塻ica de la trayectoria

close(v);