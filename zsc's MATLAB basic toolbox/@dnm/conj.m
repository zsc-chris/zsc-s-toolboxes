function ret=conj(self)
	arguments
		self dnm
	end
	ret=feval(@conj,self);
end