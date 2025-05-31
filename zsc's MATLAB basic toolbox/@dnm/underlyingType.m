function ret=underlyingType(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret(1,:)char
	end
	ret=underlyingType(self.value);
end