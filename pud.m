%
% This is a Matlab program for decomposing an n-by-n unitary matrix U as the 
% product of N = n(n-1)/2 two-level matrices according to the permutation 
% P =  [i_1, ..., i_n] of [1, ..., n]. See arXiv:1210.7366.  
%
% The Matlab command: A = pud(U,P) will generate the two-level matrices 
% A{1}, ...,  A{N} such that A{1} ... A{N}U = I_N
% One also needs the auxiliary Matlab program: genDeletePos.m to do the 
% decomposition. 
%
function finalMatrix = pud(matrixGiven, permutation)

count = 0;
for k = 1:numel(matrixGiven)
    count = count + 1;
end
count = sqrt(count);


N = (count * (count-1)) / 2 ; %N is the total number of matrices

% Create a cell array to hold all of the outputs
finalMatrix = cell(N, 1);

j = count;
count = count - 1;


%while loop goes through each column in the matrix
while count > 0
    col = zeros(j, 1);
    for i = 1:j
        col(i,1) = matrixGiven(i, permutation(j-count));
    end
    %for loop zeros all positions in a column but 1
    for idx = 1:count
        [col, unitary] = genDeletePos(col, permutation(j-idx+1), permutation(j-idx));
        matrixGiven = unitary * matrixGiven;
        finalMatrix{N} = unitary;
        N = N - 1;
    end
    count = count - 1;
end

 







