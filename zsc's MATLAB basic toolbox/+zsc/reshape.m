function B=reshape(A,sz)
%zsc.reshape	Improved version of MATLAB RESHAPE
%	B=zsc.reshape(A,*sz) supports
%	numel(sz)<2&&(isequal(sz{1},[])||isscalar(sz{1})).
%
%	See also reshape

%	Copyright 2025 Chris H. Zhao
	arguments
		A
	end
	arguments(Repeating)
		sz
	end
	if isscalar(sz)
		if isequal(sz{1},[])
			B=flatten(A);
		else
			try
				B=reshape(A,paddata(sz{1},2,fillvalue=1));
			catch ME
				rethrowAsCaller(ME)
			end
		end
	else
		B=reshape(A,sz{:});
	end
end