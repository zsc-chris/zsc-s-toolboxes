function ret=rdivide(self,other)
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@rdivide,self,other);
end