%Levent Batakci
%3/19/2021

sigma = eye(3);
sigma(3,3)=0;
p=500;
theta = RandRange(2 * pi, 0, p);
phi = RandRange(2 * pi, 0, p);
r = 1;
data = r * [cos(theta).*sin(phi) sin(theta).*sin(phi) cos(phi)]';

k=100;
params = defaultParams(k,2);
map = SOM(data, k, params);

hold on
scatter3(data(1,:),data(2,:),data(3,:), '.')
scatter3(map(1,:),map(2,:),map(3,:))
hold off