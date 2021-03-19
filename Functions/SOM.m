function map = SOM(X, k, parameters)

%Get data dimensions
[n, p] = size(X);

%Solve for lattice width
N = k^(1/2);
if(mod(N,1) >= 1e-14)
    disp("Lattice cardinality does not fit the number of dimensions!");
N = round(N);

%Initialize the parameters
Tmax = parameters(1);
a0 = parameters(2);
a1 = parameters(3);
gamma0 = parameters(4);
gamma1 = parameters(5);
T0 = parameters(6);

%Initialize the prototypes
M = zeros(n,k);
for i = 1:k
    m = RandRange(0.01,0, n);
    M(:,i ) = m;
end

%Initialize Nieghborhood matirx
neighborhood = zeros(k,k);
for x1 = 1:k
    for x2 = 1:k
        c1 = getCoord(x1);
        c2 = getCoord(x2);
        neighborhood(x1,x2) = exp(-1 /(2 * gamma0^2) * sum((c1-c2) .^ 2));
    end 
end

%LEARN!
t=0;
while(t<= Tmax)
    %Update parameters
    a = Decayed(t, a0, a1, T0);
    gamma = Decayed(t, gamma0, gamma1, T0);
    
    %Choose a random data point to introduce
    x = datasample(X,1,2);
    
    %Find the best matching unit
    minDist = norm(x- M(:,1)); 
    bmu_I = 1;
    for i = 2:k
        d = norm(x- M(:,i));
        if(d < minDist)
            minDist = d;
            bmu_I = i;
        end
    end
    bmu = M(:, bmu_I);
    
    %Update prototypes!
    c = getCoord(bmu_I);
    diff = (x-bmu);
    for i = 1:k
        c2 = getCoord(i);
        coupling_strength = exp(-1/(2*gamma^2) * norm(c-c2)^2);
        M(:,i) = M(:,i) + a * coupling_strength * diff; 
    end
end

end

