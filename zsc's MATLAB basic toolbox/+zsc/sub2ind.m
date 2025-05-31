function ind=sub2ind(sz,I)
%zsc.sub2ind	Improved version of MATLAB sub2ind
%	ind=zsc.sub2ind(sz,*I) supports numel(sz)<2.
%
%	See also sub2ind, zsc.ind2sub

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		sz(1,:){mustBeInteger,mustBeNonnegative}
	end
	arguments(Input,Repeating)
		I{mustBeNumeric}
	end
	arguments(Output)
		ind{mustBeNumeric}
	end
	ind=sub2ind(paddata(sz,2,fillvalue=1),I);
end