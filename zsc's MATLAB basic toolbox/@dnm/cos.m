function ret=cos(self)
	arguments
		self dnm
	end
	ret=feval(@cos,self);
end