function param = defaultParams(k, d)

N = k^(1/d);
if(mod(N,1) >= 1e-14)
    disp("Lattice cardinality does not fit the number of dimensions!");
end
N = round(N);
    
param = [750*k 0.9 0.01 N/3 0.5 1500];
end

