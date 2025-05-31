function ret=isvector(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=ndims(self)==1;
end