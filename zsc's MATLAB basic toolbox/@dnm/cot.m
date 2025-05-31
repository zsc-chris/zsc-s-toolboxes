function ret=cot(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@cot,self);
end