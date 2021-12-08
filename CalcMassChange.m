%% Вычисление текущей массы
function [mt, Ut] = CalcMassChange(m0, mk, alfa, U, t)

mc = m0-alfa*t;

if mc <= mk
    
    mt = mk;
    Ut = 0;
    
else
    
    mt = mc;
    Ut = U*alfa;
    
end
