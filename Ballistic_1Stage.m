%% Рассчёт траектории баллистической ракеты на дозвуковой скорости
function dydt = Ballistic_1Stage(t, y, N)    % Функция от (t,x) с дополнительными параметрами

% Входные параметры функции::
% t, x - переменные дифф. уравнения

% Вид дифф.ур. ::
% m(t)*dV/dt = alfa*U - Fs - g*R^2/(R+h)^2
% dy/dt = V
% где U - скорость истечения газов из сопла
% alfa - скорость изменения массы
% Fs - сила сопротивления

% Возвращаемое значение::
% dydt - 2dмассив из вектора координат и вектора соотв. скоростей

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

dydt = dydt';   % транспонирование вектора-строки
