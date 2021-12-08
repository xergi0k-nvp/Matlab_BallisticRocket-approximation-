%% ������� ���������� �������������� ������ ����� ���������� �������� ��������
function dUdt = Ballistic_2Stage(t, xy, N, m0)    % ������� �� (t,x) � ��������������� �����������

% ������� ��������� �������::
% t, x - ���������� ����. ���������

% ��� ����.��. ::
% dx/dt = V*cos(teta)
% dy/dt = V*sin(teta)
% dV/dt = (alfa*U-Fs)/m(t) - gg*sin(teta)
% d(teta)/dt = -gg*cos(teta)/V
% gg = g*R^2/(R+y)^2
% Fs = 0.5*c*S*p*10^(-0.125*h)

% ������������ ��������::
% dxdt - 2d������ �� ������� ��������� � ������� �����. ���������

global rocketParams globalParams useFs

if useFs
    Fs = CalcResistForce(rocketParams(N).c, rocketParams(N).S, xy(4), xy(1));
    
%     p0 = 101.325;	% ���������� ����������� ��������
%     beta = 0.125;	% ��������� �����������
%     p = p0*10^(-beta*h);	% �������� ��������� �������
%     
%     Fs = 0.5*c*S*p*V^2;	% ���������� ���� �������������
else
    Fs = 0;
end

[mt, Ut] = CalcMassChange(m0, rocketParams(N).mk, rocketParams(N).alfa, rocketParams(N).U, t);

gg = globalParams.g*globalParams.R^2/((globalParams.R+xy(4))^2);

dUdt(1) = (Ut-Fs)/mt - gg*sind(xy(2));       % 1 ��������� �������
dUdt(2) = -gg*cosd(xy(2))/xy(1);             % 2
dUdt(3) = xy(1)*cosd(xy(2));                 % 3
dUdt(4) = xy(1)*sind(xy(2));                 % 4

dUdt = dUdt';	% ���������������� �������-������
