function ret=eye(varargin)
%DNM.EYE	Add support for eye(...,"dnm").
%	Example: eye([5,5,5],["a","b","c"],"single","gpuArray","dnm")
%	Example: eye("a",5,"b",5,"c",5,"quaternion","dnm")
%
%	Note that this function create multidimensional identity matrix.
%
%	See also dnm/eyeLike, dnm/zeros, dnm/rand, dnm/false, dnm/nan.

%	Copyright 2025 Chris H. Zhao
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret dnm
	end
	ret=zeros(varargin{:},"dnm");
	if isscalar(ret)
		ret=ret+1;
	else
		sub=repmat({1:min(size(ret))},[1,ndims(ret)]);
		ret.value(zsc.sub2ind(size(ret),sub{:}))=ones(min(size(ret)),"like",ret).value;
	end
end