function ret=double(self)
%DOUBLE	Convert dnm to double precision
%	ret=DOUBLE(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@double,self);
end