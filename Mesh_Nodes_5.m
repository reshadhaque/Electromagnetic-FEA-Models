%number of mesh nodes
Nn = 5;

%Generating 1 dimensional mesh with 5 nodes
xn = linspace(0, d, Nn);
yn = zeros(1, Nn);

Ne = Nn - 1;
cl = zeros(Ne, 2); %Connectivity list

for i = 1:Ne
    for j = 1:2
        cl(i,j) = i + j - 1;
    end
end

plot(xn, yn, '*');