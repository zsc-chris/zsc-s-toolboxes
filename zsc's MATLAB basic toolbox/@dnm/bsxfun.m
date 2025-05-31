function C=bsxfun(fun,A,B)
%BSXFUN	eval function on dnms with automatic broadcasting.
%	C=BSXFUN(fun,A,B) returns dnm(fun(A.value,B.value)) after broadcasting.
%
%	See also feval

%	Copyright 2024–2025 Chris H. Zhao
	arguments(Input)
		fun(1,1)function_handle
		A dnm
		B dnm
	end
	arguments(Output)
		C dnm
	end
	C=feval(fun,A,B);
end