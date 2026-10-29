%% Human driven vehicles mode (IDM)

function state_new_IDM = HV_CF_IDM(ID,LL,FL,Le,tau,DS,LV,FV,LA,a,b,t,sigma,Q)

%% Parameter definitions
% ID: the ID number of the target car
% LL: leader's location (meters)
% FL: follower's location (meters)
% Le: the safe gap distance at a standstill (meters)
% tau: safe headway time (seconds)
% DS: desired speed (m/s)
% LV: speed of the leader (m/s)
% FV: speed of the follower (m/s)
% LA: vehicle length (m), default = 5m
% a: maximum acceleration of the follower (m/s²)
% b: desired deceleration of the follower (m/s²)
% t: simulation time step (seconds), e.g., 0.1s
% sigma: acceleration exponent (typically 4 in classical IDM)
% Q: process noise intensity

% Output:
% FV_new: updated speed of the follower (m/s)
% FL_new: updated position of the follower (m)
% Accel: acceleration during this time step (m/s²)

%% Assumptions
% FL > LL: upstream vehicle (follower) has higher location value
% FL - LL - Le > 0: the minimum spacing condition is always satisfied

%% IDM model
if ID == 1 % no vehicle ahead (free driving)
    % Free flow acceleration
    Accel = a*(1 - (FV/DS)^4); % Maximum acceleration case
else % vehicle has a leader
    % Braking acceleration
    dv = FV - LV; % relative speed between follower and leader
    ds = FL - LL - LA; % actual gap between follower and leader
    s_desired = Le + FV*tau + (FV*dv) / (2*sqrt(a*b)); % desired dynamic gap
    
    % Classical IDM model
    Accel = a * (1 - (FV/DS)^sigma - (s_desired/ds)^2); 
    % If the spacing is large and FV approaches DS, acceleration tends to 0
end

% Cap excessive braking
if Accel < -6.5
    Accel = -6.5;
end

% Add stochastic noise to acceleration
noise = sqrt(Q*t) * randn;

% Update velocity with acceleration and noise, bounded by desired speed
FV_new = min(FV + Accel*t + noise, DS);

% Update position using kinematic equation
FL_new = FL - FV*t - 0.5 * Accel * t^2;

% Regulate vehicle speed
if FV_new < 0
    FV_new = 0;      % Stop the vehicle
    Accel = 0;       % Zero acceleration
    FL_new = FL;     % Position unchanged
end

% Return updated state
state_new_IDM = [FL_new FV_new Accel];
