function ret=rescale(self,l,u,options)
	arguments(Input)
		self dnm
		l dnm{mustBeNumeric}=0
		u dnm{mustBeNumeric}=1
		options.InputMin dnm{mustBeNumeric}=min(self)
		options.InputMax dnm{mustBeNumeric}=max(self)
	end
	arguments(Output)
		ret dnm
	end
	dstar=dstarclass;
	ret=feval(@(self,l,u,InputMin,InputMax)rescale(self,l,u,InputMin=InputMin,InputMax=InputMax),self,l,u,options.InputMin,options.InputMax);
end