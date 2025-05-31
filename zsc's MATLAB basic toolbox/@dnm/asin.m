function ret=asin(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@asin,self);
end