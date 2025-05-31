function ret=all(self,dims)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	arguments(Output)
		ret dnm
	end
	ret=self.applyalong(@all,dims);
end