function ret=ldivide(self,other)
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@ldivide,self,other);
end