function ret=zerosLike(self,sz)
%ZEROSLIKE	Add support for zeros(...,like=...).
%	Example: zeros("a",5,"like",dnm(gpuArray(single(0))))
%	Example: zeros(5,5,"like",dnm(gpuArray(single(0)),"a"))
%
%	See also dnm/zeros, dnm/onesLike, dnm/eyeLike, dnm/randLike, dnm/falseLike, dnm/nanLike.
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
	ret=dnm(zeros(paddata(zsc.cell2mat(sz(2,:)),[1,2],"fillvalue",1),"like",self.value),zsc.cell2mat(sz(1,:)));
end