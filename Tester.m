%Levent Batakci
%3/19/2021

sigma = eye(3);
sigma(3,3)=0;
p=1000;
theta = RandRange(pi , 0, p);
phi = RandRange(pi, 0, p);
r = 1;
data = r * [cos(theta).*sin(phi) sin(theta).*sin(phi) cos(phi)]'; %Sphere :D

k=100;
N = k^(1/2);
params = defaultParams(k,2);
map = SOM(data, k, params);

hold on
scatter3(data(1,:),data(2,:),data(3,:), '.')

X = map(1,:);
Y = map(2,:);
Z = map(3,:);
scatter3(X,Y,Z)

%Mesh visualization
for i = 1:k
    c = getCoord(i,N);
    x = c(1);
    y = c(2);
    
    anchor = map(:,i);
    if(x < N)
        target = map(:,getKey(x+1,y,N));
        X = [anchor(1) target(1)]';
        Y = [anchor(2) target(2)]';
        Z = [anchor(3) target(3)]';
        plot3(X,Y,Z);
    end
    
    if(y < N)
        target = map(:,getKey(x,y+1,N));
        X = [anchor(1) target(1)]';
        Y = [anchor(2) target(2)]';
        Z = [anchor(3) target(3)]';
        plot3(X, Y, Z);
    end
end

hold off