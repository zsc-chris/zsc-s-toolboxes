function ret=isnumeric(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=isnumeric(self.value);
end