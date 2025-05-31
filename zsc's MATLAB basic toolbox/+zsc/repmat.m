function B=repmat(A,r)
%zsc.repmat	Improved version of MATLAB REPMAT
%	B=zsc.repmat(A,*r) supports numel(sz)<2.
%
%	See also repmat

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		A
	end
	arguments(Input,Repeating)
		r(1,:){mustBeInteger,mustBeNonnegative}
	end
	arguments(Output)
		B
	end
	B=repmat(A,paddata(zsc.cell2mat(r),2,fillvalue=1));
end