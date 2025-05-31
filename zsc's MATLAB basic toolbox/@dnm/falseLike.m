function ret=falseLike(self,sz)
%FALSELIKE	Add support for false(...,"like",...).
%	Example: false("a",5,"like",dnm(gpuArray(logical(0))))
%	Example: false(5,5,"like",dnm(gpuArray(logical(0)),"a"))
%
%	See also dnm/false, dnm/zerosLike, dnm/eyeLike, dnm/randLike, dnm/trueLike, dnm/nanLike.

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
	ret=dnm(false(paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),"like",self.value),zsc.cell2mat(sz(1,:)));
end