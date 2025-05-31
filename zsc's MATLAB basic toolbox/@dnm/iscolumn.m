function ret=iscolumn(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=isvector(self);
end