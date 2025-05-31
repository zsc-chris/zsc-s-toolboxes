function sz=size(self,dims)
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}
	end
	arguments(Output,Repeating)
		sz(1,:)double{mustBeInteger,mustBeNonnegative}
	end
	if isequal(dims,cell.empty(1,0))
		dims={1:ndims(self)};
	end
	dims=zsc.cell2mat(dims);
	if ischar(dims)||iscellstr(dims)||isstring(dims)
		dims=index(self.dimnames,string(dims));
	end
	[sz{1:nargout}]=size(self.value,dims);
end