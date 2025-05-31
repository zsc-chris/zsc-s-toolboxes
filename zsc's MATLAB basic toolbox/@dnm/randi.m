function ret=randn(varargin)
%DNM.RANDN	Add support for randn(...,"dnm").
%	Example: randn([5,5,5],["a","b","c"],"single","gpuArray","dnm")
%	Example: randn("a",5,"b",5,"c",5,"single","gpuArray","dnm")
%
%	See also dnm/randnLike, dnm/rand, dnm/randi.

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret dnm
	end
	if ~isempty(varargin)&&isa(varargin{1},"RandStream")
		s=varargin(1);
		varargin=varargin(2:end);
	else
		s={};
	end
	zsc.assert(~isempty(varargin),message("MATLAB:minrhs"))
	irange=varargin{1};
	varargin=varargin(2:end);
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
	ret=dnm(randi(s{:},irange,paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),dtypes{:}),zsc.cell2mat(sz(1,:)));
end