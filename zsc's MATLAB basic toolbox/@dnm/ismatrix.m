function ret=ismatrix(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=ndims(self)==2;
end