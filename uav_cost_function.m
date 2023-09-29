function cost_value = uav_cost_function(k,plotfig)

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
Q_z(1,1) = k(1);
Q_z(2,2) = 1;
Q_z(3,3) = k(2);

R_z = k(3);
G_z = ss(A_z,B_z, C_z, 0);

K_z = lqi(G_z,Q_z,R_z);
K1_z = K_z(1:2);
K2_z = K_z(3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_x = C_x_o'*C_x_o;
Q_x(1,1) = k(4);
Q_x(2,2) = 1;
Q_x(3,3) = k(5);

R_x = k(6);
G_x = ss(A_x_o,B_x_o, C_x_o, 0);

K_x = lqi(G_x,Q_x,R_x);
K1_x = K_x(1:2);
K2_x = K_x(3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_y = C_y_o'*C_y_o;
Q_y(1,1) = k(7);
Q_y(2,2) = 1;
Q_y(3,3) = k(8);

R_y = k(9);
G_y = ss(A_y_o,B_y_o, C_y_o, 0);

K_y = lqi(G_y,Q_y,R_y);
K1_y = K_y(1:2);
K2_y = K_y(3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_phi = C_phi'*C_phi;
Q_phi(1,1) = k(10);
Q_phi(2,2) = 1;
Q_phi(3,3) = k(11);

R_phi = k(12);
G_phi = ss(A_phi,B_phi, C_phi, 0);

K_phi = lqi(G_phi,Q_phi,R_phi);
K1_phi = K_phi(1:2);
K2_phi = K_phi(3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_theta = C_theta'*C_theta;
Q_theta(1,1) = k(13);
Q_theta(2,2) = 1;
Q_theta(3,3) = k(14);

R_theta = k(15);
G_theta = ss(A_theta,B_theta, C_theta, 0);

K_theta = lqi(G_theta,Q_theta,R_theta);
K1_theta = K_theta(1:2);
K2_theta = K_theta(3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Q_yaw = C_yaw'*C_yaw;
Q_yaw(1,1) = k(16);
Q_yaw(2,2) = 1;
Q_yaw(3,3) = k(17);

R_yaw = k(18);
G_yaw = ss(A_yaw,B_yaw, C_yaw, 0);

K_yaw = lqi(G_yaw,Q_yaw,R_yaw);
K1_yaw = K_yaw(1:2);
K2_yaw = K_yaw(3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% assignin('base', 'Ke',k(1))
% assignin('base', 'Kd',k(2))
% assignin('base', 'K0',k(3))
% assignin('base', 'K1',k(4))
assignin('base', 'K_z',K_z)
assignin('base', 'K_x',K_x)
assignin('base', 'K_y',K_y)
assignin('base', 'K_phi',K_phi)
assignin('base', 'K_theta',K_theta)
assignin('base', 'K_yaw',K_yaw)

out = sim('uav_6DOF_ss_v5_inner_outer_loop_ga.mdl');

%cost_value = sum(out.iae_z) + sum(out.iae_x) + sum(out.iae_y) + sum(out.iae_phi) + sum(out.iae_theta) + sum(out.iae_yaw);
%cost_value = sum(out.iae_z) + sum(out.iae_x) + sum(out.iae_y);
cost_value = rmse(out.x_ref, out.x) + rmse(out.y_ref, out.y) + rmse(out.z_ref, out.z);

% err = reference - output;
% 
% [n,~] = size(err);
% cost_value = 0;
% 
% for i=1:n
%     
% cost_value = cost_value + t(i) * abs(err(i));  % ITAE
% %  cost_value=cost_value+(err(i))^2 ;  % ISE
% %   cost_value=cost_value+abs(err(i));  % IAE
% 
% end

% if plotfig
%     figure(3)
%     plot(t,reference,t,output)
%     end
end