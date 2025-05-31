function ret=isUnderlyingType(self,classname)
	arguments(Input)
		self dnm
		classname(1,1)string
	end
	arguments(Output)
		ret logical
	end
	ret=isUnderlyingType(self.value,classname);
end