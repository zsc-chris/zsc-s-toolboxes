function ret=sign(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@sign,self);
end