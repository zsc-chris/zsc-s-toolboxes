function ret=isscalar(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=ndims(self)==0;
end