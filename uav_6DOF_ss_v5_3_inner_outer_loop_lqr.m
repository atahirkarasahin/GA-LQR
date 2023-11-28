clear
clc
% used GA optimized parameter

% m = 0.5;          % mass of uav, 0.486            (kg)
% g = 9.81;          % gravity                       (m/s^2)
% r = 0.25;          % distance of mass center,0.225 (m) 
% c = 0.1;        %27 scaling factor m^-1
% I_x = 0.0196;    % moment of inertia of uav      (kg.m^2)
% I_y = 0.0196;
% I_z = 0.0264;

%GA_coef = [2.8000 10.1935 1.0000 1.0000 9.5806 4.0645 1.0000 12.6452 	18.1613 2.8000 5.9032 64.1290 77.2000 612.6774 126.6452 129.4000 434.9355 3.4516];
% Last GA coeff
%GA_coef = [2.8000 10.1935 1.0000 1.0000 9.5806 4.0645 1.000 12.6452 18.1613 2.8000 5.9032 64.1290 77.2000 612.6774 126.6452 129.4000 434.9355 3.4516];

%40,20,85,20,0.1825,907,42sn
GA_coef = [3.4000		10.8065		1.6129		1.6000			16.3226		2.2258		4.0000		19.3871			2.8387		4.6000		2.2258		149.3226		182.8000		301.9355		219.8065		50.8000		374.2581		1.6129];

m = 0.46;          % mass of uav, 0.486            (kg)
g = 9.81;          % gravity                       (m/s^2)
r = 0.127;          % distance of mass center,0.225 (m) 
I_x = 2.24e-3;    % moment of inertia of uav      (kg.m^2)
I_y = 2.9e-3;
I_z = 5.3e-3;

A_z = zeros(2,2);
B_z = zeros(2,1);
C_z = zeros(1,2);

A_x_o = zeros(2,2);
B_x_o = zeros(2,1);
C_x_o = zeros(1,2);

A_y_o = zeros(2,2);
B_y_o = zeros(2,1);
C_y_o = zeros(1,2);

A_phi = zeros(2,2);
B_phi = zeros(2,1);
C_phi = zeros(1,2);

A_theta = zeros(2,2);
B_theta = zeros(2,1);
C_theta = zeros(1,2);

A_yaw = zeros(2,2);
B_yaw = zeros(2,1);
C_yaw = zeros(1,2);

A_z(1,2) = 1;
B_z(2,1) = 1/m;
C_z(1,1) = 1;

A_x_o(1,2) = 1;
B_x_o(2,1) = g;
C_x_o(1,1) = 1;

A_y_o(1,2) = 1;
B_y_o(2,1) = -g;
C_y_o(1,1) = 1;

A_phi(1,2) = 1;
B_phi(2,1) = 1/I_x;
C_phi(1,1) = 1;

A_theta(1,2) = 1;
B_theta(2,1) = 1/I_y;
C_theta(1,1) = 1;

A_yaw(1,2) = 1;
B_yaw(2,1) = 1/I_z;
C_yaw(1,1) = 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_z = C_z'*C_z;
Q_z(1,1) = GA_coef(1,1);
Q_z(2,2) = 1;
Q_z(3,3) = GA_coef(1,2);
Q_z

R_z = GA_coef(1,3);
G_z = ss(A_z,B_z, C_z, 0);

K_z = lqi(G_z,Q_z,R_z)
K1_z = K_z(1:2);
K2_z = K_z(3);

G1_z = ss(A_z-B_z.*K1_z, -B_z.*K2_z, C_z, 0);
s = tf('s');
Gi = 1/s;

Gc_z = feedback(Gi*G1_z, 1);

disp('Gc_z')
eig(Gc_z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_x = C_x_o'*C_x_o;
Q_x(1,1) = GA_coef(1,4);
Q_x(2,2) = 1;
Q_x(3,3) = GA_coef(1,5);
Q_x

R_x = GA_coef(1,6);
G_x = ss(A_x_o,B_x_o, C_x_o, 0);

K_x = lqi(G_x,Q_x,R_x)
K1_x = K_x(1:2);
K2_x = K_x(3);

G1_x = ss(A_x_o-B_x_o.*K1_x, -B_x_o.*K2_x, C_x_o, 0);
s = tf('s');
Gi = 1/s;

Gc_x = feedback(Gi*G1_x, 1);

disp('Gc_x')
eig(Gc_x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_y = C_y_o'*C_y_o;
Q_y(1,1) = GA_coef(1,7);
Q_y(2,2) = 1;
Q_y(3,3) = GA_coef(1,8);
Q_y

R_y = GA_coef(1,9);
G_y = ss(A_y_o,B_y_o, C_y_o, 0);

K_y = lqi(G_y,Q_y,R_y)
K1_y = K_y(1:2);
K2_y = K_y(3);

G1_y= ss(A_y_o-B_y_o.*K1_y, -B_y_o.*K2_y, C_y_o, 0);
s = tf('s');
Gi = 1/s;

Gc_y= feedback(Gi*G1_y, 1);

disp('Gc_y')
eig(Gc_y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_phi = C_phi'*C_phi;
Q_phi(1,1) = GA_coef(1,10);
Q_phi(2,2) = 1;
Q_phi(3,3) = GA_coef(1,11);
Q_phi

R_phi = GA_coef(1,12);
G_phi = ss(A_phi,B_phi, C_phi, 0);

K_phi = lqi(G_phi,Q_phi,R_phi)
K1_phi = K_phi(1:2);
K2_phi = K_phi(3);

G1_phi= ss(A_phi-B_phi.*K1_phi, -B_phi.*K2_phi, C_phi, 0);
s = tf('s');
Gi = 1/s;

Gc_phi= feedback(Gi*G1_phi, 1);

disp('Gc_phi')
eig(Gc_phi)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_theta = C_theta'*C_theta;
Q_theta(1,1) = GA_coef(1,13);
Q_theta(2,2) = 1;
Q_theta(3,3) = GA_coef(1,14);
Q_theta

R_theta = GA_coef(1,15);
G_theta = ss(A_theta,B_theta, C_theta, 0);

K_theta = lqi(G_theta,Q_theta,R_theta)
K1_theta = K_theta(1:2);
K2_theta = K_theta(3);

G1_theta= ss(A_theta-B_theta.*K1_theta, -B_theta.*K2_theta, C_theta, 0);
s = tf('s');
Gi = 1/s;

Gc_theta= feedback(Gi*G1_theta, 1);

disp('Gc_theta')
eig(Gc_theta)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_yaw = C_yaw'*C_yaw;
Q_yaw(1,1) = GA_coef(1,16);
Q_yaw(2,2) = 1;
Q_yaw(3,3) = GA_coef(1,17);
Q_yaw

R_yaw = GA_coef(1,18);
G_yaw = ss(A_yaw,B_yaw, C_yaw, 0);

K_yaw = lqi(G_yaw,Q_yaw,R_yaw)
K1_yaw = K_yaw(1:2);
K2_yaw = K_yaw(3);

G1_yaw= ss(A_yaw-B_yaw.*K1_yaw, -B_yaw.*K2_yaw, C_yaw, 0);
s = tf('s');
Gi = 1/s;

Gc_yaw= feedback(Gi*G1_yaw, 1);

disp('Gc_yaw')
eig(Gc_yaw)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%