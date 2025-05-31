function ret=length(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret double{mustBeInteger,mustBeNonnegative}
	end
	ret=length(self.value);
end