function ret=infLike(self,sz)
%INFLIKE	Add support for inf(...,like=...).
%	Example: inf("a",5,"like",dnm(gpuArray(single(0))))
%	Example: inf(5,5,"like",dnm(gpuArray(single(0)),"a"))
%
%	See also dnm/inf, dnm/zerosLike, dnm/eyeLike, dnm/randLike, dnm/falseLike, dnm/nanLike.

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
	sz=parsedimargs(self.dimnames,sz);
	ret=dnm(inf(paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),"like",self.value),zsc.cell2mat(sz(1,:)));
end