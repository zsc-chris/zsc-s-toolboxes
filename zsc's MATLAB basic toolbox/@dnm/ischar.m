function ret=ischar(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=ischar(self.value);
end