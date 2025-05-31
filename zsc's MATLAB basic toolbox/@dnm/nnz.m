function ret=nnz(self,dims)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	arguments(Output)
		ret dnm
	end
	self=self~=0;
	ret=self.applyalong(@sum,dims);
end