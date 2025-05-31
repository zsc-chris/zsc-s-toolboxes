function ret=randnLike(self,varargin)
%RANDNLIKE	Add support for randn(...,like=...).
%	Example: randn("a",5,"like",dnm(gpuArray(single(0))))
%	Example: randn(5,5,"like",dnm(gpuArray(single(0)),"a"))
%
%	See also dnm/randn, dnm/randLike, dnm/randnLike.
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret dnm
	end
	if ~isempty(varargin)&&isa(varargin{1},"RandStream")
		s=varargin(1);
		sz=varargin(2:end);
	else
		s={};
		sz=varargin;
	end
	sz=parsedimargs(self.dimnames,sz);
	ret=dnm(randn(s{:},paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),"like",self.value),zsc.cell2mat(sz(1,:)));
end