function ret=sym(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(ifinline(isUnderlyingType(self,"string"),@()@str2sym,@()@sym),self);
end