function ret=flip(self,dims)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	arguments(Output)
		ret dnm
	end
	ret=self.applyalong(@flip,dims,mode="iterate",keepdims=true);
end