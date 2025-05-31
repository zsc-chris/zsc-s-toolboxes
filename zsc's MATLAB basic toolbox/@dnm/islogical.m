function ret=islogical(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=islogical(self.value);
end