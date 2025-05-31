function ret=empty(varargin,options)
%DNM.EMPTY	Add support for DNM.EMPTY(...).
%	Example: DNM.EMPTY([0,0,5],["a","b","c"],"single","gpuArray","dnm")
%	Example: DNM.EMPTY([0,0,5],["a","b","c"],"single","gpuArray","dnm")
%
%	See also dnm/ones, dnm/eye, dnm/rand, dnm/false, dnm/nan.
	arguments(Input,Repeating)
		varargin
	end
	arguments(Input)
		options.like
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
	assert(prod(zsc.cell2mat(sz(2,:)))==0,message("MATLAB:class:emptyMustBeZero"))
	dstar=dstarclass;
	ret=dnm(createArray(paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),dtypes{:},dstar{options}),zsc.cell2mat(sz(1,:)));
end