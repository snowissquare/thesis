clear 
clc
close all

b2 = 1;
d1 = 0.2;
s = 0.33;

t_period = [0 70];

N0 = 1;
T0 = 0.2;
I0 = 0.15;
M0 = 0;    

x1_0 = N0 - 1/b2;
x2_0 = T0;
x3_0 = I0 - s/d1;
x4_0 = M0;

y0 = [x1_0;x2_0;x3_0;x4_0];


opts = odeset('RelTol',1e-6,'AbsTol', 1e-6);
[t,y] = ode45(@(t,y) solver(t,y), t_period, y0, opts);

u = zeros(1,length(y));
for i = 1:length(y)
    [~,u(1,i)] = solver(t(i),y(i,:));
end

y(:,1) = y(:,1) + 1;
y(:,3) = y(:,3) + 1.65;


for i = 1:length(y)
    if y(i, 2) < 1e-4
        fprintf('t_zero = %d\n', i)
        break
    end
end
fprintf('t_true_zero = %d\n', t(i))
fprintf('Dmax = %f\n', max(y(:,4:4)))

fprintf('n min = %f\n', min(y(:,1:1)))
fprintf('tmax = %f\n', max(y(:,2:2)))
hold on
plot(t,y(:,1:4),'-','linewidth',1)
%plot(t,u,'-','linewidth',1)
plot([0 70],[0.75,0.75],'--k','linewidth',1)
legend('Здоровые клетки','Раковые клетки','Имунные клетки','Доза препарата','Порог здоровых клеток')
grid on
xlabel('Дни')
ylabel('Количество клеток в популяции')
