function ret=diff_functional(functional,fun,n,eps,distribution)
%diff_functional	Functional Derivative
%	Either symbolically or numerically calculate the derivative of a
%	functional.
%
%	diff_functional(functional:function_handle(function_handle -> double|
%		sym, fun:function_handle(double -> double)|symfun, n:positive
%		integer) -> function_handle(n doubles -> double) returns
%		δ^nfunctional/(δfunction)^n
%
%	Thus, these should be equivalent (a=b=c, with numerical error):
%	>> a=@(x1,x2)feval(diff_functional(@(f)feval(diff_functional(@(f)integral2(@(x1,x2)x1.*x2.*f(x1).*f(x2),0,1,0,1),f,1,0.1),x2),@(x)x,1,0.1),x1)
%	>> b=diff_functional(@(f)integral2(@(x1,x2)x1.*x2.*f(x1).*f(x2),0,1,0,1),@(x)x,2)
%	>> syms x y1 y2;c=diff_functional(@(f)int(int(y1*y2*f(y1)*f(y2),y1,0,1),y2,0,1),symfun(x,x),2)
%
%	Note that this function is more flexible than functionalDerivative, as
%	the latter uses @(function)int(function(x),-inf,inf) as the functional,
%	unlike here where you can define any form of functional.
%
%	See also diff, diff_numerical, functionalDerivative

%	Copyright 2024–2025 Chris H. Zhao
	arguments
		functional(1,1)function_handle
		fun(1,1){mustBeA(fun,["function_handle","symfun"])}
		n(1,1)double{mustBePositive,mustBeInteger}=1
		eps(1,1)double=5e-3*(n==1)+5e-2*(n==2)+5e-1*(n>=3)
		distribution(1,1)function_handle=@(x)exp(-x.^2/2)/sqrt(2*pi)	
	end
	if isa(fun,"symfun")
		xs="x"+string(1:n);
		as="a"+string(1:n);
		syms([xs,as,"x"],'real')
		eval("syms ret("+join(string(xs),",")+")")
		ret=symfun(eval("simplify(subs(diff(functional(fun"+join("+"+as+"*dirac(x-"+xs+")","")+"),"+join(string(as),",")+"),["+join(string(as),",")+"],zeros(1,"+n+")))"),eval("["+join(string(xs),",")+"]"));
	else
		xs="x"+string(1:n);
		as="a"+string(1:n);
		ret=eval("@("+join(string(xs),",")+")"+join("feval(diff_numerical(@("+as+")","")+"functional(@(x)fun(x)"+join("+"+as+"*distribution(("+xs+"-x)/eps)","")+")"+join(repmat("),0)",1,n),"")+"/eps^n");
	end
end