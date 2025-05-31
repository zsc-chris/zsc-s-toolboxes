function ret=nanmean(self,dims)
	arguments
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	ret=mean(self,dims,"omitnan");
end