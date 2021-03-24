function M = SOM(X, k, parameters)

%Get data dimensions
[n, p] = size(X);

%Solve for lattice width
N = k^(1/2);
if(mod(N,1) >= 1e-14)
    disp("Lattice cardinality does not fit the number of dimensions!");
end
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
    m = RandRange(0.001,0, n);
    M(:,i ) = m;
end

C = zeros(2,k);
for i = 1:k
    C(:, i) = getCoord(i,N);
end

%LEARN!
t=0;
while(t<= Tmax)
    %Update parameters
    a = Decayed(t, a0, a1, T0);
    gamma = Decayed(t, gamma0, gamma1, T0);
    
    %Choose a random data point to introduce
    x = datasample(X,1,2);
    
    [~, bmu_I] = min(vecnorm(M - x));
    
    %Update prototypes!
    c = getCoord(bmu_I,N);
    diff = (x-M);
    
    H = exp(-1/(2*gamma^2) * (vecnorm(c-C).^2));
    M = M + a * H .* diff;
    
    t=t+1;
end
end

