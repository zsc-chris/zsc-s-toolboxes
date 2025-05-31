function ret=paddata(self,m,options)
	arguments
		self dnm
		m(1,:)double{mustBeInteger,mustBeNonnegative}
		options.Dimension(1,:){mustBeA(options.Dimension,["logical","double","string","char","cell","missing"])}=1:numel(m)
		options.Fillvalue(1,1)
		options.Pattern(1,1)string{mustBeMember(options.Pattern,["constant","edge","circular","flip","reflect"])}
		options.Side(1,1)string{mustBeMember(options.Side,["trailing","leading","both"])}="trailing"
	end
	dstar=dstarclass;
	zsc.assert(~all(isfield(options,["FillValue","Pattern"])),message("MATLAB:resize:PatternAndFillValue"))
	ret=self.applyalong(@(x,dim,varargin)zsc.paddata(x,m,"dimension",dim,varargin{:}),options.Dimension,keepdims=true,additionalinput={dstar{rmfield(options,"Dimension")}});
end