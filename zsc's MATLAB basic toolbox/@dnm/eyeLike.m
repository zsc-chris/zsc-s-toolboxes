function ret=eyeLike(self,sz)
%EYELIKE	Add support for eye(...,like=...).
%	Example: eye("a",5,"like",dnm(gpuArray(single(0))))
%	Example: eye(5,5,"like",dnm(gpuArray(single(0)),"a"))
%
%	See also dnm/eye, dnm/zerosLike, dnm/randLike, dnm/falseLike, dnm/nanLike.

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		sz
	end
	arguments(Output)
		ret dnm
	end
	ret=zeros(sz{:},"like",self);
	if isscalar(ret)
		ret=ret+1;
	else
		sub=repmat({1:min(size(ret))},[1,ndims(ret)]);
		ret.value(zsc.sub2ind(size(ret),sub{:}))=ones(min(size(ret)),"like",self).value;
	end
end