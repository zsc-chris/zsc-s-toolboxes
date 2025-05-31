function ret=plus(self,other)
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@plus,self,other);
end