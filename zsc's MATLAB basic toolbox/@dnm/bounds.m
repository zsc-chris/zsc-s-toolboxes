function [ret1,ret2]=bounds(self,dims,missingflag)
	arguments(Input)
		self
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		missingflag(1,1){mustBeMember(missingflag,["omitmissing","omitnan","omitnat","omitundefined","includemissing","includenan","includenat","includeundefined"])}="omitmissing"
	end
	arguments(Output)
		ret1 dnm
		ret2 dnm
	end
	ret1=min(self,[],dims,missingflag);
	ret2=max(self,[],dims,missingflag);
end