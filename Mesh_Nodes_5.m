%number of mesh nodes

Simple1D;

err = [];
for Nn = (5:5:50)+1;

%Generating 1 dimensional mesh with 5 nodes
xn = linspace(0, d, Nn);
yn = zeros(1, Nn);
p = [xn' yn'];


Ne = Nn - 1;
cl = zeros(Ne, 2); %Connectivity list

%Setting the connectivity list
for i = 1:Ne
    for j = 1:2
        cl(i,j) = i + j - 1;
    end
end

%Calculate Mesh length
le = zeros(1,Ne);
for i = 1:Ne
    le(i) = xn(cl(i,2))-xn(cl(i,1));
end

figure(1);
hold all;
patch('faces', cl, 'Vertices', p)
%plot(xn, yn, 'marker', 'o');

%Allocate memory for stiffness matrix and load vector
K = zeros(Nn, Nn);
f = zeros(Nn, 1);

%global assembly






for i = 1:Ne
  
        %Stiffness Matrix
        K(cl(i,1), cl(i,1)) = K(cl(i,1), cl(i,1)) + (e/le(i)); 
        K(cl(i,1), cl(i,2)) = K(cl(i,1), cl(i,2)) - (e/le(i));
        K(cl(i,2), cl(i,1)) = K(cl(i,2), cl(i,1)) - (e/le(i));
        K(cl(i,2), cl(i,2)) = K(cl(i,2), cl(i,2)) + (e/le(i));

        %Force vector
       f(cl(i,1)) = f(cl(i,1)) - le(i)*p0/2;
       f(cl(i,2)) = f(cl(i,2)) - le(i)*p0/2;

      
end

%Imposing boundary conditions
%left point
K(1,1) = 1;
for j = 2:Nn
    K(1,j) = 0;
end
f(1) = v0;

%right point
K(Nn,Nn) = 1;
for j = 1:Nn-1
    K(Nn,j) = 0;
end
f(Nn) = 0;

%Solving system of equations (The most powerful syntax of MATLAB software)

V = K\f;

%plot(xn, V, 'color', 'r');

Vfe = Interpolate1D1D(xn, V, cl, x);

AreaError = sum(abs(vx-Vfe))*100/abs(sum(vx));
err(end+1) = AreaError;

L2Error = sqrt(sum((vx-Vfe).^2* x(2)));

sprintf('AreaError = %.4f', AreaError)
sprintf('L2Error = %.1e', L2Error)

end


