function ret=repmat(self,r)
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		r(1,:)
	end
	r=parsedimargs(self.dimnames,r);
	zsc.assert(isempty(r)||isequal(sort(zsc.cell2mat(r(1,:))),unique(zsc.cell2mat(r(1,:)))),"DNM:RepeatedDimension","Repeated dimension not allowed.")
	self.dimnames(index(self.dimnames,zsc.cell2mat(r(1,:))))=zsc.cell2mat(r(1,:));
	dict=dictionary(zsc.cell2mat(r(1,:)),r(2,:));
	r=paddata(lookup(dict,self.dimnames,"fallbackvalue",{1}),2,"fillvalue",{1});
	ret=dnm(repmat(self.value,r{:}),self.dimnames);
end