function B=squeeze(A,dims)
%ZSC.SQUEEZE Improved version of MATLAB SQUEEZE.
%	B=ZSC.SQUEEZE(A,dims) adds a dimension keyword to the builtin version
%	that allows one to remove only certain 1-sized dimensions.
%
%	See also squeeze.
%
%	Note this function squeezes row vector to column, which is different
%	from the builtin.

%	Copyright 2024 Chris H. Zhao
	arguments
		A
		dims(1,:)double{mustBePositive,mustBeInteger}=1:ndims(A)
	end
	dims=unique(dims);
	sz=size(A);
	dims=dims(dims<=numel(sz));
	% if any(sz(dims)~=1)
	% 	warning("The size of dimension to be removed is not 1.")
	% end
	sz(dims(sz(dims)==1))=[];
	B=reshape(A,paddata(sz,[1,2],"fillvalue",1));
end