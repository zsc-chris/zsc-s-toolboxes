function ret=trimdata(self,m,options)
	arguments
		self dnm
		m(1,:)double{mustBeInteger,mustBeNonnegative}
		options.Dimension(1,:){mustBeA(options.Dimension,["logical","double","string","char","cell","missing"])}=1:numel(m)
		options.Side(1,1)string{mustBeMember(options.Side,["trailing","leading","both"])}="trailing"
	end
	dstar=dstarclass;
	ret=self.applyalong(@(x,dim,varargin)zsc.trimdata(x,m,"dimension",dim,varargin{:}),options.Dimension,keepdims=true,additionalinput={dstar{rmfield(options,"Dimension")}});
end