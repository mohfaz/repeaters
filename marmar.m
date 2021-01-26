Z = nan(108,108);
min(lat_area)

X = repmat(long_area',[108,1]);
Y = repmat(lat_area,[1,108]);
for i = 1: 108
    i
   x = long_area(i); 
   y = lat_area(i);
   for ii = 1:108*108
       
        if(X(ii) == x && Y(ii) == y)
           Z(ii) = TBv(i);
            
        end
       
   end
end
%%
A = scatter(lat_area,long_area,TBv,'o','filled');
c = TBv./max(TBv);
color = [];
for i = 1:108
    color = [color;ones(1,3)*c(i)];
    
end
A.CData = color;