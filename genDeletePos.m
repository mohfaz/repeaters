function [finalCol, unitaryMatrix] = genDeletePos (startCol, pos_to_del, pos_h)

count = 0;
for k = 1:numel(startCol)
    count = count + 1;
end


b = startCol(pos_to_del, 1);
a = startCol(pos_h, 1);

denom = sqrt(abs(a)^2 + abs(b)^2);
if (denom == 0 )
    a1 = 1;
    b1 = 0;
    a2 = 1;
    b2 = 0;
else
    a1 = conj(a)/denom;
    b1 = conj(b)/denom;
    a2 = a/denom;
    b2 = -b/denom;
end

unitaryMatrix = zeros(count, count);

%create an identity matrix
for j = 1:count
    unitaryMatrix(j,j) = 1;
end

%create the two-level unitary matrix
    unitaryMatrix(pos_h, pos_h) = a1;
    unitaryMatrix(pos_h, pos_to_del) = b1;
    unitaryMatrix(pos_to_del, pos_h) = b2;
    unitaryMatrix(pos_to_del, pos_to_del) = a2;

finalCol = unitaryMatrix * startCol;

    