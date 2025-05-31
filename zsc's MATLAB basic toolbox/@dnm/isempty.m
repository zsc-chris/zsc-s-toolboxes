function ret=isempty(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=isempty(self.value);
end