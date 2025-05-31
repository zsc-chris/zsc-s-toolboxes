function ret=false(varargin)
%DNM.FALSE	Add support for false(...,"dnm").
%	Example: false([5,5,5],["a","b","c"],"gpuArray","dnm")
%	Example: false("a",5,"b",5,"c",5,"gpuArray","dnm")
%
%	See also dnm/falseLike, dnm/ones, dnm/eye, dnm/rand, dnm/true, dnm/nan.

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret dnm
	end
	ind=find(cellfun(@isnumeric,varargin),1,'last');
	if isempty(ind)
		dtypes=varargin;
		sz={};
	else
		if numel(varargin)>ind&&~isscalar(string(varargin{ind+1}))
			ind=ind+1;
		end
		dtypes=varargin(ind+1:end);
		sz=varargin(1:ind);
	end
	sz=parsedimargs([],sz);
	ret=dnm(false(paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end