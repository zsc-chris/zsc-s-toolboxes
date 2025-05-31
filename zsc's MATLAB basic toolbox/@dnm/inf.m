function ret=inf(varargin)
%DNM.INF	Add support for inf(...,"dnm").
%	Example: inf([5,5,5],["a","b","c"],"single","gpuArray","dnm")
%	Example: inf("a",5,"b",5,"c",5,"single","gpuArray","dnm")
%
%	See also dnm/infLike, dnm/zeros, dnm/eye, dnm/rand, dnm/false, dnm/nan.

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
	ret=dnm(inf(paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end