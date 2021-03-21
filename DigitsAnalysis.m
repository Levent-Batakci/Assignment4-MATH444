%Levent Batakci
%3/21/2021

%Load the data
load HandwrittenDigits.mat

%Trim the data
c1 = 1;
c2 = 3;
c3 = 9;
X(:, I~=c1 & I~=c2 & I~=c3) = [];
[n,p] = size(X);

k=100;
N = k^(1/2);
params = defaultParams(k, 2);
M = SOM(X, k, params);


%Visualize protoypes by finding closest matches
V = zeros(160,160);
for i = 1:10
    for j = 1:10
        key = getKey(i,j,N);
        m = M(:, key);
        
        %Find the best matching unit
        [~, bmu_I] = min(vecnorm(X - m));
        bmu = X(:, bmu_I);
        
        V((i-1)*16+1:i*16, (j-1)*16+1:j*16) = reshape(bmu,16,16)';
    end
end

imagesc(V)