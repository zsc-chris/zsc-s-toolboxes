function I=ind2sub(sz,ind)
%zsc.ind2sub	Improved version of MATLAB ind2sub
%	*I=zsc.ind2sub(sz,ind) supports numel(sz)<2.
%
%	See also ind2sub, zsc.sub2ind

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		sz(1,:){mustBeInteger,mustBeNonnegative}
		ind{mustBeNumeric}
	end
	arguments(Output,Repeating)
		I{mustBeNumeric}
	end
	[I{1:nargout}]=ind2sub(paddata(sz,2,fillvalue=1),ind);
end