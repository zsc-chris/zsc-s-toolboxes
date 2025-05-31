function ret=isfloat(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret logical
	end
	ret=isfloat(self.value);
end