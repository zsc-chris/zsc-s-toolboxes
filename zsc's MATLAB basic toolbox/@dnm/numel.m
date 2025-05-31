function ret=numel(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret double{mustBeInteger,mustBeNonnegative}
	end
	ret=numel(self.value);
end