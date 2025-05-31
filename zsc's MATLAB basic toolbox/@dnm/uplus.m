function ret=uplus(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@uplus,self);
end