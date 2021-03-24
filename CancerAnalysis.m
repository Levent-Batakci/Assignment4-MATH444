%Levent Batakci
%3/21/2021

%Load data
load WisconsinBreastCancerData_Unpacked.mat

%Sort data
X = Data_WCD_Matrix;
I = I_Label';
benign = X(:,I==1);
malignant = X(:,I==2);

%SOM!
k = 100;
N = k^(1/2);
params = defaultParams(k,2);
M = SOM(X, k, params);

hold on
%Place the benign data!
for x = benign
    [~, bmu_I] = min(vecnorm(M - x));
    c = getCoord(bmu_I, N);
    
    %Place a dot
    theta = RandRange(2*pi,0,1);
    r = RandRange(0.5,0,1);
    x_ = r*cos(theta) + c(1);
    y_ = r*sin(theta) + c(2);
    scatter(x_, y_, 250, 'g.');
end

%Place the malignant data!
for x = malignant
    [~, bmu_I] = min(vecnorm(M - x));
    c = getCoord(bmu_I, N);
    
    %Place a dot
    theta = RandRange(2*pi,0,1);
    r = RandRange(0.5,0,1);
    x_ = r*cos(theta) + c(1);
    y_ = r*sin(theta) + c(2);
    scatter(x_, y_, 250, 'r.');
end

%%SET UP CIRCLES!%%
cirlces = zeros(N,N);
q1 = [1:N]'*ones(1,N);
q2 = ones(N,1)*[1:N];
Q = [q1(:) q2(:)];
% Define the distance squared matrix
D2 = zeros(k,k);
for i = 1:k
    for j = 1:i
        D2(i,j) = norm(Q(i,:) - Q(j,:))^2;
        D2(j,i) = D2(i,j);
    end
end

% Plotting the buttons on the map
thplot = linspace(0,2*pi,k);
cc = cos(thplot);
ss = sin(thplot);
for j = 1:k
    plot(Q(j,1)*ones(1,k) + 0.5*cc,Q(j,2)*ones(1,k)+0.5*ss,'k-','LineWidth',2)
    hold on
end
axis('square')
axis([0,N+1,0,N+1])
set(gca,'FontSize',20)
set(gca, 'visible', 'off')
%%%%%