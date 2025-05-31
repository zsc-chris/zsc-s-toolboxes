function ret=dnm2table(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret table
	end
	ret=cell2table(num2cell(self.value));
end