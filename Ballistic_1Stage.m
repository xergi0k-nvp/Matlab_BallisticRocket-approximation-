%% ������� ���������� �������������� ������ �� ���������� ��������
function dydt = Ballistic_1Stage(t, y, N)    % ������� �� (t,x) � ��������������� �����������

% ������� ��������� �������::
% t, x - ���������� ����. ���������

% ��� ����.��. ::
% m(t)*dV/dt = alfa*U - Fs - g*R^2/(R+h)^2
% dy/dt = V
% ��� U - �������� ��������� ����� �� �����
% alfa - �������� ��������� �����
% Fs - ���� �������������

% ������������ ��������::
% dydt - 2d������ �� ������� ��������� � ������� �����. ���������

global rocketParams globalParams useFs

if useFs
    Fs = CalcResistForce(rocketParams(N).c, rocketParams(N).S, y(1), y(2));
else
    Fs = 0;
end

[mt, Ut] = CalcMassChange(rocketParams(N).m0, rocketParams(N).mk, rocketParams(N).alfa, rocketParams(N).U, t);

gg = globalParams.g*globalParams.R^2/((globalParams.R+y(1))^2);

dydt(1) = y(2);
dydt(2) = (Ut - Fs - gg)/mt;

dydt = dydt';   % ���������������� �������-������
