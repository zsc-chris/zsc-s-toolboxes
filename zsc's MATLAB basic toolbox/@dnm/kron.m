function ret=kron(self,other)
	arguments(Input)
		self
		other
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@zsc.kron,self,other,broadcastsize=false);
end