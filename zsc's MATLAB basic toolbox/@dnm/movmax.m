function ret=movmax(self,k,dims,nanflag,options)
	arguments(Input)
		self dnm
		k(1,:){mustBeA(k,["numeric","cell"])}
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="omitmissing"
		options.Endpoints(1,:){mustBeTrue(options.Endpoints,"@(Endpoints)isscalar(Endpoints)&&isnumeric(Endpoints)||succeeds(@()assert(ismember(string(Endpoints),[""shrink"",""discard"",""fill""])))")}="shrink"
		options.SamplePoints(1,:){mustBeA(options.SamplePoints,["numeric","cell"])}
	end
	if ~iscell(k)
		k={k};
	end
	if islogical(dims)
		dims=find(dims);
	end
	if isnumeric(dims)
		dims=string(arrayfun(@(x)ifinline(x<=ndims(self),@()self.dimnames(x),@()"x"+string(x)),dims));
	end
	if ischar(dims)||iscellstr(dims)||isstring(dims)
		dims=string(dims);
	end
	if succeeds(@()assert(string(options.Endpoints)=="fill"))
		options.Endpoints=-inf;
	end
	dstar=dstarclass;
	ret=applykernel(self,@(x,dims,nanflag)max(x,[],dims,nanflag),flatten(zsc.cat(1,num2cell(dims),k)),dstar{options},mode="dist",additionalinput={nanflag});
end