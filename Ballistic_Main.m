%% �������� �������������� ������
function Ballistic_Main()

tspan = 0:50:1e+5;  % �������� ��������������
global rocketParams PathAxes VelAxes

for i = 1:size(rocketParams, 2)
    
    % 1 ������ ����� - ���������� (��� ��������� ������������� ���������) ��������
    init = [0 0];       % ��������� �������� ��� 1 ������
    opt1 = odeset('Events', @(t,y) StopCond1(t, y, i));
    [t, y] = ode45(@(t,y) Ballistic_1Stage(t, y, i), tspan, init, opt1);
    Y = y(:, 1);	% ������ ��������� y
    V = y(:, 2);	% ������ ���������
    T = t;          % ������ �������� �������
    
%     plot(PathAxes, T, Y);
%     plot(VelAxes, Y, V);
    
    h = Y(end, 1);  % ������ ��� ������� ����������� ��������� ��������
    
    m0 = CalcMassChange(rocketParams(i).m0, rocketParams(i).mk, rocketParams(i).alfa, rocketParams(i).U, t(end));

    % 2 ������ - ���������� ��������� ��������, ����������� ��������������
    % ������������ ��������
    
    init = [rocketParams(i).Vctrl rocketParams(i).teta 0 h];       % ��������� �������� ��� 2 ������
    opt2 = odeset('Events', @(t,y) StopCond2(t, y));
    [t, xy] = ode45(@(t,y) Ballistic_2Stage(t, y, i, m0), tspan, init, opt2);

    T = [T; t + T(end)];                    % ����������� �������� ������� � 2 ���
    V = [V; xy(:, 1)];                      % ����������� �������� ���������
    X = [zeros(size(Y, 1), 1); xy(:, 3)];   % ����������� �������� ��������� x
    Y = [Y; xy(:, 4)];                      % ����������� �������� ��������� y
    
    plot(PathAxes, X, Y);
    plot(VelAxes, Y, V);
    
end


%%

%% event-������� ��� �������� ode45
% ��������� ������� ��� V = ����������� ��������
function [value, isterminal, direction] = StopCond1(t, y, i) 
global rocketParams

value      = y(2) - rocketParams(i).Vctrl;  % ����������� ��������
isterminal = 1;     % ��������� ����������
direction  = 1;     % ����������� �����

% ��������� ������� ��� V = ����������� ��������
function [value, isterminal, direction] = StopCond2(t, y) 
value      = y(4);  % ����������� ��������
isterminal = 1;     % ��������� ����������
direction  = -1;	% ����������� �����
%%