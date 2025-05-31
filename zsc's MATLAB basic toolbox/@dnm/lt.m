function ret=lt(self,other)
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@lt,self,other);
end