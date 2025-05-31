function ret=ifftshift(self,dims)
	arguments
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell","missing"])}=1:ndims(self)
	end
	ret=self.applyalong(@ifftshift,dims,mode="iterate",keepdims=true);
end