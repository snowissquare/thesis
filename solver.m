function [y_dot,u] = solver(t,y)

a1 = 0.2;
a2 = 0.3;
a3 = 0.1;
b1 = 1;
b2 = 1;
c1 = 1;
c2 = 0.5;
c3 = 1;
c4 = 1;
d1 = 0.2;
d2 = 1;
r1 = 1.5;
r2 = 1;
s = 0.33;
alpha = 0.3;
rho = 0.01;



x1 = y(1);
x2 = y(2);
x3 = y(3); 
x4 = y(4);

A11 = -r2*(1+x1*b2);
A12 = -c4*(x1+1/b2);
A14 = -a3*(x1+1/b2);
A21 = -c3*x2;
A22 = r1*(1-b1*x2) - (c2*s/d1+c3/b2);
A23 = -c2*x2;
A24 = -a2*x2;
A32 = rho*(x3 + s/d1)/(alpha + x2) - c1*(x3 + s/d1) - x4;
A33 = -d1;
A34 = -a1*(x3 + s/d1) + x2;
A44 = -d2;

A = [A11,A12,0,A14;A21,A22,A23,A24;0,A32,A33,A34;0,0,0,A44];
B = [0;0;0;1];

Q = diag([0,150,0,0.1]);

R = 5;


[K,S,e] = lqr(A,B,Q,R);
u = -K * [x1,x2,x3,x4]';    

%u = min(max(u,0),1);
u = max(u,0);
 

%% forwarding the dyanmics 
y_dot = A * [x1;x2;x3;x4] + B * u;
end