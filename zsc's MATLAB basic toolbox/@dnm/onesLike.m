function ret=onesLike(self,sz)
%ONESLIKE	Add support for ones(...,like=...).
%	Example: ones("a",5,"like",dnm(gpuArray(single(0))))
%	Example: ones(5,5,"like",dnm(gpuArray(single(0)),"a"))
%
%	See also dnm/ones, dnm/zerosLike, dnm/eyeLike, dnm/randLike, dnm/falseLike, dnm/nanLike.

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
	ret=dnm(ones(paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),"like",self.value),zsc.cell2mat(sz(1,:)));
end