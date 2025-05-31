function ret=linspace(x1,x2,n,dim,options)
	arguments(Input)
		x1 dnm{mustBeNonempty}
		x2 dnm{mustBeNonempty}
		n(1,1)double{mustBeInteger,mustBePositive}
		dim(1,1)string="linspace"
	end
	arguments(Input)
		options.precise=true
	end
	arguments(Output)
		ret dnm
	end
	if options.precise
		x1.dimnames=[x1.dimnames,dim];
		x2.dimnames=[x2.dimnames,dim];
		ret=arrayfun(@(x1,x2)linspace(x1,x2,n)',x1,x2,"uniformoutput",false);
		ret=transpose(dnm(cell2mat(transpose(ret,[dim,ret.dimnames(1)])),ret.dimnames),[dim,ret.dimnames(1)],false);
	else
		tmp=dnm(linspace(0,1,n),[missing,dim]);
		ret=x1.*flip(tmp)+x2.*tmp;
	end
end