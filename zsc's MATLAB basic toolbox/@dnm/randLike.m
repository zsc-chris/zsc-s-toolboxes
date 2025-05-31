function ret=randLike(self,varargin)
%RANDLIKE	Add support for rand(...,like=...).
%	Example: rand("a",5,"like",dnm(gpuArray(single(0))))
%	Example: rand(5,5,"like",dnm(gpuArray(single(0)),"a"))
%
%	See also dnm/rand, dnm/randiLike, dnm/randnLike.
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
	ret=dnm(rand(s{:},paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),"like",self.value),zsc.cell2mat(sz(1,:)));
end