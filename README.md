# GA-LQR
In this paper, a linear quadratic regulator (LQR) controller operating according to the genetically tuned inner-outer loop structure is proposed for trajectory tracking of a quadrotor. Setting the parameters of a linear controller operating according to the inner-outer loop structure is a matter that requires profound expertise. Optimization algorithms are used to cope with the solution of this problem. First, the dynamic equations of motion of the quadrotor are obtained and modelled in state-space form. The LQR controller, which will operate according to the inner-outer loop structure in the MATLAB/Simulink environment, has been developed separately for 6 degrees of freedom (DOF) of the quadrotor. Since adjusting these parameters will take a long time, a genetic algorithm has been used at this point. The LQR controller and controllers with optimized coefficients obtained by the trial-and-error method were evaluated according to their success following the reference trajectory and responses to specific control inputs. According to the results obtained, it was observed that the genetically adjusted LQR controller produced more successful outcomes.