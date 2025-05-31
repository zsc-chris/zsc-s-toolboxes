function ret=del2(self,h)
%del2	Discrete Laplacian.
%	ret=del2(self,*h), h can be dims, *(dims=h), h, or *h.
%
%	Note: To avoid ambiguity, h will not be broadcast if it is scalar.
%	Note: zsc.del2 is called for this function.
%
%	See also zsc.del2, del2

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		h(1,:)
	end
	arguments(Output)
		ret dnm
	end
	h=paddata(h,1,fillvalue={1});
	if isscalar(h)
		if ischar(h{1})||iscellstr(h{1})||isstring(h{1})
			h=num2cell(string(h{1}));
			h(2,:)={1};
			h=h(:);
		end
	end
	h=parsedimargs(self.dimnames,h);
	zsc.assert(isempty(h)||isequal(sort(zsc.cell2mat(h(1,:))),unique(zsc.cell2mat(h(1,:)))),"DNM:RepeatedDimension","Repeated dimension not allowed.")
	ret=self.applyalong(@zsc.del2,zsc.cell2mat(h(1,:)),keepdims=true,vectorized=false,additionalinput=h(2,:));
end