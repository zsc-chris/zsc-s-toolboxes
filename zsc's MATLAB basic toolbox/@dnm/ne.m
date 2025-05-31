function ret=ne(self,other)
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@ne,self,other);
end