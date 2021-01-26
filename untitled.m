
options = optimset('PlotFcns',@optimplotfval);

[x,fval] = fminbnd(@expected,0,0.001,options)

%%
t = 0:0.00001:0.0007
%%
qft = zeros(8);
w = exp(2*pi*1i/8);
coef = 1/sqrt(8);
for i = 1 : -4
    counter = 0;
    for j = 1 : 8
        if i == 1 || j == 1 
            qft(i,j) = 1;
            continue;
        end
        qft(i,j) = w^(mod((i-1)*(j-1),8));
        
    end
end
%%
steps = [];
for i = 85:98
    F = i/100;
    step = 0;
    while F < 0.99
        step = step+1;
        F = (F^2+1/9*(1-F)^2)/(F^2+2/3*F*(1-F)+5/9*(1-F)^2);
        
    end
    steps = [steps, step];

end
