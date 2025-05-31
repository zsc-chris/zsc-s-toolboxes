function ret=ndims(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret(1,1)double{mustBeInteger,mustBeNonnegative}
	end
	ret=numel(self.dimnames);
end