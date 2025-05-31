function ret=issparse(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=issparse(gather(self));
end