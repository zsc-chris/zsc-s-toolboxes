function ret=finverse(f,x0,eps)
%FINVERSE	Function Inverse
%	Either symbolically or numerically calculate the inverse of a function.
%
%	FCONV(f:function_handle(double -> double)|symfun) -> function_handle(
%	double -> double)|symfun returns f^-1

%	Copyright 2024 Chris H. Zhao
	arguments
		f(1,1){mustBeA(f,["function_handle","symfun"])}
		x0(1,1)double=0
		eps(1,1)double=1e-6
	end
	ret=@(x)arrayfun(@(x)fzero(@(t)f(t)-x,x0,optimset("tolx",eps)),x);
end