figure 
hold on
for l0 = [10:20:100]

    fplot(@(l) exp(-l/l0))


    
end
 xlim([0,100])
grid on,
ylabel("exp(-l/l_0)","FontSize",18)
xlabel("Distance (l)","FontSize",18)
legend(legendmaker("l_0", [10:20:100]),"FontSize",18)



