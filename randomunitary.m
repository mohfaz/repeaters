 function [W]=randomunitary(n) 
%THIS FUNCTION GENERATES A RANDOM 2^n by 2^n UNITARY MATRIX
W=randi(3,2^n);
H=0.5*(W+W');
W=expm(1i*H);
