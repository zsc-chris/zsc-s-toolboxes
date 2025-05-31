function ret=isstring(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=isstring(self.value);
end