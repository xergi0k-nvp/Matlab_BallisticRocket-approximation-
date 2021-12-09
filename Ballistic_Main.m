%% Движение баллистической ракеты
function Ballistic_Main()

tspan = 0:50:1e+5;  % интервал интегрирования
global rocketParams PathAxes VelAxes

for i = 1:size(rocketParams, 2)
    
    % 1 стадия полёта - дозвуковая (или выбранная пользователем пороговая) скорость
    init = [0 0];       % начальные значения для 1 стадии
    opt1 = odeset('Events', @(t,y) StopCond1(t, y, i));
    [t, y] = ode45(@(t,y) Ballistic_1Stage(t, y, i), tspan, init, opt1);
    Y = y(:, 1);	% массив координат y
    V = y(:, 2);	% массив скоростей
    T = t;          % массив значений времени
    
%     plot(PathAxes, T, Y);
%     plot(VelAxes, Y, V);
    
    h = Y(end, 1);  % высота при которой достигается пороговая скорость
    
    m0 = CalcMassChange(rocketParams(i).m0, rocketParams(i).mk, rocketParams(i).alfa, rocketParams(i).U, t(end));

    % 2 стадия - достижение пороговой скорости, добавляется горизонтальная
    % составляющая скорости
    
    init = [rocketParams(i).Vctrl rocketParams(i).teta 0 h];       % начальные значения для 2 стадии
    opt2 = odeset('Events', @(t,y) StopCond2(t, y));
    [t, xy] = ode45(@(t,y) Ballistic_2Stage(t, y, i, m0), tspan, init, opt2);

    T = [T; t + T(end)];                    % объединение массивов времени с 2 фаз
    V = [V; xy(:, 1)];                      % объединение массивов скоростей
    X = [zeros(size(Y, 1), 1); xy(:, 3)];   % объединение массивов координат x
    Y = [Y; xy(:, 4)];                      % объединение массивов координат y
    
    plot(PathAxes, X, Y);
    plot(VelAxes, Y, V);
    
end


%%

%% event-функция для решателя ode45
% остановка функции при V = контрольная скорость
function [value, isterminal, direction] = StopCond1(t, y, i) 
global rocketParams

value      = y(2) - rocketParams(i).Vctrl;  % проверяемая величина
isterminal = 1;     % остановка вычислений
direction  = 1;     % направление роста

% остановка функции при V = контрольная скорость
function [value, isterminal, direction] = StopCond2(t, y) 
value      = y(4);  % проверяемая величина
isterminal = 1;     % остановка вычислений
direction  = -1;	% направление роста
%%