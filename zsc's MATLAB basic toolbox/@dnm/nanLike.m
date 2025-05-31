function ret=nanLike(self,sz)
%NANLIKE	Add support for nan(...,like=...).
%	Example: nan("a",5,"like",dnm(gpuArray(single(0))))
%	Example: nan(5,5,"like",dnm(gpuArray(single(0)),"a"))
%
%	See also dnm/nan, dnm/zerosLike, dnm/eyeLike, dnm/randLike, dnm/falseLike, dnm/infLike.

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
	ret=dnm(nan(paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),"like",self.value),zsc.cell2mat(sz(1,:)));
end