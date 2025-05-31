function ret=iscell(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=iscell(self.value);
end