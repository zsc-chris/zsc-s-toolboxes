function d=neps(x,p)
	arguments(Input)
		x
		p=[]
	end
	arguments(Output)
		d
	end
	if nargin==1
		zsc.assert(isUnderlyingType(x,"float"),message("MATLAB:eps:invalidClassName"))
		x=abs(x);
		d=eps(x-eps(x));
	else
		zsc.assert(succeeds(@()zsc.assert(startsWith("like",string(x)))),message("MATLAB:eps:mustBeLike"))
		zsc.assert(isUnderlyingType(p,"float"),message("MATLAB:eps:invalidPrototype"))
		d=eps(1-eps("like",p));
	end
end