function ret=prctile(self,p,dims,options)
	arguments(Input)
		self dnm
		p(:,1){mustBeNumericOrLogical}
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		options.Method(1,1)string{mustBeMember(options.Method,["exact","approximate"])}="exact"
	end
	dstar=dstarclass;
	ret=applyalong(self,@(self,dims,p,varargin)prctile(self,p,dims,varargin{:}),dims,mode="flatten",keepdims=true,additionalinput={p,dstar{options}});
end