function ret=fconv(f,g,eps)
%FCONV	Function Convolution
%	Either symbolically or numerically calculate the convolution of two
%	functions.
%
%	FCONV(f:function_handle(double -> double)|symfun, g:
%		function_handle(double -> double)|symfun) -> function_handle(double
%		-> double)|symfun returns f*g:x -> ∫f(t)g(x-t)dt
%
%	FCONV(f,@(x)f(-x)) calculates unnormalized autocorrelation.
%	FCONV(f,@(x)g(-x)) calculates unnormalized correlation (f and g not
%	exchangable, otherwise the result is mirrored by x -> -x)
%
%	See also conv

%	Copyright 2024 Chris H. Zhao
	arguments
		f(1,1){mustBeA(f,["function_handle","symfun"])}
		g(1,1){mustBeA(g,["function_handle","symfun"])}
		eps(1,1)double=1e-6
	end
	if class(f)=="symfun"&&class(g)=="symfun"
		syms x t
		ret(x)=int(f(t)*g(x-t),t,-inf,inf);
	else
		ret=@(x)integral(@(t)(double(f(t)).*double(g(x'-t)))',-inf,inf,"abstol",eps,"reltol",eps,"arrayvalued",true);
	end
end