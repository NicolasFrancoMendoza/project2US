function F = fFourBarLinkage(x,C)  
    a = C(1); %Manivela
    b = C(2); %Acoplador
    c = C(3); %Salida
    d = C(4); %Piso
    T1 = C(5); %Inclinación suelo
    T2 = C(6); %Ángulo entrada

    F(1) = -a*cosd(T2)+c*cosd(x(2))+d*cos(T1)-b*cosd(x(1)); 
    F(2) = -a*sind(T2)+c*sind(x(2))+d*sin(T1)-b*sind(x(1));
end