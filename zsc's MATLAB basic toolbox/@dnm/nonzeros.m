function ret=nonzeros(self)
	arguments(Input)
		self dnm
	end
	arguments(Output)
		ret dnm
	end
	[~,nonzeros]=find(self);
end