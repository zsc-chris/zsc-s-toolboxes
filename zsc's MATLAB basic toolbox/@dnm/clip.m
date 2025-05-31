function ret=clip(self,lower,upper)
	arguments(Input)
		self dnm
		lower dnm{mustBeNumeric}
		upper dnm{mustBeNumeric}
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@clip,self,lower,upper);
end