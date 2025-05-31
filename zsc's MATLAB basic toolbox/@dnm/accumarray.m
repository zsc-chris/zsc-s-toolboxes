function ret=accumarray(ind,self,sz,fun,fillval,issparse)
%ACCUMARRAY	Accumulate array by indices/subscripts.
%	ret=ACCUMARRAY(ind,self,sz,fun,fillval,issparse)
%	ind		:	{*arrays/*dnms/**arrays/**dnms/mapping}.
%		If ind is not a cell, ind={ind} will be called before processing.
%		ind operates on a new dnm, so if ind is not {**arrays/**dnms},
%		can only use x1, x2, ... in indexing. Same as subsref syntax.
%	self	:	dnm
%	sz		:	{*sz} or {**sz} or {sz,dim}
%		If ind is not a cell, ind={ind} will be called before processing.
%	fun		:	Input to fun has a flattened dimension with other
%		dimensions untouched. It doesn't matter to squeeze or not.
%	fillval	:	will be broadcast along other dimensions.
%
%	Note: issparse is not supported. It can only be false.
%	Note: Accumarray, like subsasgn, does not support renaming dimensions.
%		Rename dimensions (if you want) after accumarray.
%
%	See also accumarray, dnm/subsref

%	Copyright 2025 Chris H. Zhao
	arguments
		ind{mustBeA(ind,["cell","dnm","double","struct","table","dictionary"])}
		self dnm
		sz{mustBeA(sz,["cell","double","struct","table","dictionary"])}=[]
		fun{mustBeTrue(fun,"@(fun)isequal(fun,[])||isa(fun,""function_handle"")")}=@sum
		fillval=[]
		issparse(1,1)logical{mustBeTrue(issparse,"@(issparse)~issparse")}=false
	end
	if ~iscell(ind)
		ind={ind};
	end
	[new,~]=parsedimargsindexing(dnm,ind,"subsasgn");
	if isequal(sz,[])
		sz={size(new),new.dimnames};
	end
	if ~iscell(sz)
		sz={sz};
	end
	if isequal(fun,[])
		fun=@sum;
	end
	if isequal(fillval,[])
		fillval=dnm(createArray([1,1],"like",gather(self)));
	else
		fillval=dnm(fillval);
	end
	sz=parsedimargs(new.dimnames,sz);
	new=paddata(new,zsc.cell2mat(sz(2,:)),dimension=zsc.cell2mat(sz(1,:)));
	ind_=dnm(zsc.reshape(1:numel(new),size(new)),new.dimnames);
	ind=subsref(ind_,substruct("()",ind));
	[self,~]=feval(@deal,self,ind);
	ind=flatten(gather(ind));
	[self,dim]=flatten(self,new.dimnames);
	star=starclass;
	self=gather(star(self,index(self.dimnames,dim)));
	ret=accumarray(ind,(1:numel(self))',[numel(new),1],@(x){x});
	ret=cellfun(@(x)ifinline(isequal(x,[]),@(){fillval},@(){fun(cat(dim,self{x}))}),ret);
	ret=dnm(zsc.reshape(ret,size(new)),new.dimnames);
	ret=cell2mat(ret);
end