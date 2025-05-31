function ret=nanmedian(self,dims)
	arguments
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	ret=median(self,dims,"omitnan");
end