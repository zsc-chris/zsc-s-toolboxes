function [ret,index]=mink(self,k,dims,options)
	arguments(Input)
		self dnm
		k(1,1)double{mustBeInteger,mustBeNonnegative}
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		options.ComparisonMethod(1,1)string{mustBeMember(options.ComparisonMethod,["auto","real","abs"])}="auto"
	end
	arguments(Output)
		ret dnm
		index dnm
	end
	dstar=dstarclass;
	[ret,index]=self.applyalong(@(x,dim,varargin)mink(x,k,dim,varargin{:}),dims,keepdims=true,mode="flatten",additionalinput={dstar{options}});
end