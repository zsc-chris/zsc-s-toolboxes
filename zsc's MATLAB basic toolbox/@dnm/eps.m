function ret=eps(self,p)
	arguments(Input)
		self
		p dnm=dnm
	end
	arguments(Output)
		ret dnm
	end
	if nargin==1
		zsc.assert(isUnderlyingType(self,"float"),message("MATLAB:eps:invalidClassName"))
		ret=feval(@eps,self);
	else
		zsc.assert(succeeds(@()zsc.assert(startsWith("like",string(self)))),message("MATLAB:eps:mustBeLike"))
		zsc.assert(isUnderlyingType(p,"float"),message("MATLAB:eps:invalidPrototype"))
		ret=dnm(eps("like",gather(p)));
	end
end