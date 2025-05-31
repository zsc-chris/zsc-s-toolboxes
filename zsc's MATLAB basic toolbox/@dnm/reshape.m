function ret=reshape(self,sz)
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		sz(1,:)
	end
	sz=parsedimargs(self.dimnames,sz);
	zsc.assert(isempty(sz)||isequal(sort(zsc.cell2mat(sz(1,:))),unique(zsc.cell2mat(sz(1,:)))),"DNM:RepeatedDimension","Repeated dimension not allowed.")
	ret=dnm(zsc.reshape(self.value,sz{:}),zsc.cell2mat(sz(1,:)));
end