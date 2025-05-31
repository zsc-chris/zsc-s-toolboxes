function ret=randiLike(self,varargin)
%RANDILIKE	Add support for randi(...,like=...).
%	Example: randi("a",5,"like",dnm(gpuArray(single(0))))
%	Example: randi(5,5,"like",dnm(gpuArray(single(0)),"a"))
%
%	See also dnm/randi, dnm/randLike, dnm/randiLike.
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
	zsc.assert(~isempty(varargin),message("MATLAB:minrhs"))
	irange=varargin{1};
	sz=varargin(2:end);
	sz=parsedimargs(self.dimnames,sz);
	ret=dnm(randi(s{:},irange,paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),"like",self.value),zsc.cell2mat(sz(1,:)));
end