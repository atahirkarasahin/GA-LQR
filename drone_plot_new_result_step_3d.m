%load ("uav_io_ga_3d_270923.mat")

x_ref = lqr.x_ref';
y_ref = lqr.y_ref';
z_ref = lqr.z_ref';

x_ref_3d = lqr_3d.x_ref';
y_ref_3d = lqr_3d.y_ref';
z_ref_3d = lqr_3d.z_ref';

phi_ref = lqr.phi_ref';
theta_ref = lqr.theta_ref';
yaw_ref = lqr.yaw_ref';

lqr_x = lqr.pos(:,2)';
lqr_y = lqr.pos(:,3)';
lqr_z = lqr.pos(:,4)';

lqr_phi = lqr.angle(:,2)';
lqr_theta = lqr.angle(:,3)';
lqr_yaw = lqr.angle(:,4)';

ga_lqr_x = ga_lqr.pos(:,2)';
ga_lqr_y = ga_lqr.pos(:,3)';
ga_lqr_z = ga_lqr.pos(:,4)';

ga_lqr_phi = ga_lqr.angle(:,2)';
ga_lqr_theta = ga_lqr.angle(:,3)';
ga_lqr_yaw = ga_lqr.angle(:,4)';

lqr_x_3d = lqr_3d.pos(:,2)';
lqr_y_3d = lqr_3d.pos(:,3)';
lqr_z_3d = lqr_3d.pos(:,4)';

ga_lqr_3d_x = ga_lqr_3d.pos(:,2)';
ga_lqr_3d_y = ga_lqr_3d.pos(:,3)';
ga_lqr_3d_z = ga_lqr_3d.pos(:,4)';


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %% 3d plot

% figure
% plot3(x_ref_3d, y_ref_3d, z_ref_3d, 'b-', 'LineWidth',2)
% hold on
% plot3(lqr_x_3d, lqr_y_3d, lqr_z_3d,'g-', 'LineWidth',3)
% hold on
% plot3(ga_lqr_3d_x, ga_lqr_3d_y, ga_lqr_3d_z,'r-', 'LineWidth',3)
% hold off
% 
% grid on
% xlabel('X Inertial, x(m)','Interpreter','latex')
% ylabel('Y Inertial, y(m)','Interpreter','latex')    
% zlabel('Height, z(m)','Interpreter','latex')
% legend('Reference', 'Simulation','GA-Simulation','Interpreter','latex')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% X axis figure

% figure()
% hold on
% plot(x_ref_3d(1,1:19999), 'LineWidth',2);
% plot(lqr_x_3d(1,1:19999), 'LineWidth',2);
% plot(ga_lqr_3d_x(1,1:19999), 'LineWidth',2);
% hold off
% 
% xlabel('Time, t(s)', 'Interpreter','latex');
% ylabel('X Inertial, x(m)', 'Interpreter','latex');
% legend('Reference', 'Simulation', 'GA-Simulation', 'Interpreter','latex');
% xticks([0 50/0.01 100/0.01 150/0.01 199/0.01])
% xticklabels({'0','50','100','150', '200'})
% grid ()
% ax = gca;
% ax.GridLineStyle = '-.';

% figure()
% hold on
% plot(x_ref(1,1:1499), 'LineWidth',2);
% plot(lqr_x(1,1:1499), 'LineWidth',2);
% plot(ga_lqr_x(1,1:1499), 'LineWidth',2);
% hold off
% 
% xlabel('Time, t(s)', 'Interpreter','latex');
% ylabel('X Inertial, x(m)', 'Interpreter','latex');
% legend('Reference', 'LQR', 'GA-LQR', 'Interpreter','latex');
% xticks([0 5/0.01 10/0.01 15/0.01])
% xticklabels({'0','5','10','15'})
% grid ()
% ax = gca;
% ax.GridLineStyle = '-.';

% %% Y axis figure
% figure()
% hold on
% plot(y_ref(1,999:2499), 'LineWidth',2);
% plot(lqr_y(1,999:2499), 'LineWidth',2);
% plot(ga_lqr_y(1,999:2499), 'LineWidth',2);
% hold off
% 
% xlabel('Time, t(s)', 'Interpreter','latex');
% ylabel('Y Inertial, x(m)', 'Interpreter','latex');
% legend('Reference', 'LQR', 'GA-LQR', 'Interpreter','latex');
% xticks([0 5/0.01 10/0.01 15/0.01])
% xticklabels({'0','5','10','15'})
% grid ()
% ax = gca;
% ax.GridLineStyle = '-.';
% 

% figure()
% hold on
% plot(y_ref_3d(1,1:20000), 'LineWidth',2);
% plot(lqr_y_3d(1,1:20000), 'LineWidth',2);
% plot(ga_lqr_3d_y(1,1:20000), 'LineWidth',2);
% hold off
% 
% xlabel('Time, t(s)', 'Interpreter','latex');
% ylabel('Y Inertial, x(m)', 'Interpreter','latex');
% legend('Reference', 'Simulation', 'GA-Simulation', 'Interpreter','latex');
% xticks([0 50/0.01 100/0.01 150/0.01 199/0.01])
% xticklabels({'0','50','100','150', '200'})
% grid ()
% ax = gca;
% ax.GridLineStyle = '-.';
% %% Z axis figure
% figure()
% hold on
% plot(z_ref(1,1999:3499), 'LineWidth',2);
% plot(lqr_z(1,1999:3499), 'LineWidth',2);
% plot(ga_lqr_z(1,1999:3499), 'LineWidth',2);
% hold off
% 
% xlabel('Time, t(s)', 'Interpreter','latex');
% ylabel('Height, z(m)', 'Interpreter','latex');
% legend('Reference', 'LQR', 'GA-LQR', 'Interpreter','latex');
% xticks([0 5/0.01 10/0.01 15/0.01])
% xticklabels({'0','5','10','15'})
% grid ()
% ax = gca;
% ax.GridLineStyle = '-.';
% 

figure()
hold on
plot(z_ref_3d(1,1:20000), 'LineWidth',2);
plot(lqr_z_3d(1,1:20000), 'LineWidth',2);
plot(ga_lqr_3d_z(1,1:20000), 'LineWidth',2);
hold off

xlabel('Time, t(s)', 'Interpreter','latex');
ylabel('Height, z(m)', 'Interpreter','latex');
legend('Reference', 'Simulation', 'GA-Simulation', 'Interpreter','latex');
xticks([0 50/0.01 100/0.01 150/0.01 199/0.01])
xticklabels({'0','50','100','150', '200'})
grid ()
ax = gca;
ax.GridLineStyle = '-.';
% %% roll axis figure
% figure()
% hold on
% plot(phi_ref(1,2999:4499), 'LineWidth',2);
% plot(lqr_phi(1,2999:4499), 'LineWidth',2);
% plot(ga_lqr_phi(1,2999:4499), 'LineWidth',2);
% hold off
% 
% xlabel('Time, t(s)', 'Interpreter','latex');
% ylabel('Height, z(m)', 'Interpreter','latex');
% legend('Reference', 'LQR', 'GA-LQR', 'Interpreter','latex');
% xticks([0 5/0.01 10/0.01 15/0.01])
% xticklabels({'0','5','10','15'})
% grid ()
% ax = gca;
% ax.GridLineStyle = '-.';