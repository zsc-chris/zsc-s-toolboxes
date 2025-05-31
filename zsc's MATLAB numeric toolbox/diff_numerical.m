function ret=diff_numerical(fun,n,eps)
%diff_numerical	Numerical Derivative of Function
%	Approximate the derivative using central difference method.
%
%	See also diff, diff_functional

%	Copyright 2023 Chris H. Zhao
	arguments
		fun(1,1)function_handle
		n(1,1)double{mustBePositive,mustBeInteger}=1
		eps(1,1)double{mustBePositive}=1e-4
	end
	if n>1
		ret=@(x)(feval(diff_numerical(fun,n-1,eps),x+eps)-feval(diff_numerical(fun,n-1,eps),x-eps))/(2*eps);
	else
		ret=@(x)(fun(x+eps)-fun(x-eps))/(2*eps);
	end
end