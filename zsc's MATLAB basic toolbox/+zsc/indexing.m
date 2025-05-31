function ret=indexing(input,S,options)
%zsc.indexing	Improved version of MATLAB INDEXING.
%	ret=zsc.indexing(input,S,*,fillvalue=missing,pattern="constant") uses
%	python-style indexing, allowing for interpolation.
	arguments
		input
		S(1,:)struct{mustBeTrue(S,"@(S)S(1).type==""()"""),mustBeTrue(S,"@(S)isscalar(unique(cellfun(@(x)keyHash(size(x)),S(1).subs)))"),mustBeTrue(input,S,"@(input,S)numel(S(1).subs)>=find(size(input)~=1,1,""last"")")}
		options.fillvalue(1,1)=missing
		options.pattern(1,1)string{mustBeMember(options.pattern,["constant","edge","circular","flip","reflect"])}="constant"
	end
	subs=S(1).subs;
	sz=size(subs{1});
	subs=cellfun(@(x)x(:),subs,"uniformoutput",false);
	switch options.pattern
		case "constant"
			invalid=any(cell2mat(subs)>size(input,1:numel(subs)),2)|any(cell2mat(subs)<ones([1,numel(subs)]),2);
			subs=arrayfun(@(x,i)clip(x{1},1,size(input,i)),subs,1:numel(subs),"uniformoutput",false);
		case "edge"
			subs=arrayfun(@(x,i)clip(x{1},1,size(input,i)),subs,1:numel(subs),"uniformoutput",false);
		case "circular"
			subs=arrayfun(@(x,i)mod1(x{1},size(input,i)),subs,1:numel(subs),"uniformoutput",false);
		case "flip"
			subs=arrayfun(@(x,i)feval(@(x)ifinline(x<=size(input,i),@()x,@()size(input,i)*2+1-x),mod1(x{1},size(input,i)*2)),subs,1:numel(subs),"uniformoutput",false);
		case "reflect"
			subs=arrayfun(@(x,i)ternary(size(input,i)>1,feval(@(x)ternary(x<=size(input,i),x,size(input,i)*2-1-x),mod1(x{1},size(input,i)*2-2)),ones("like",x{1})),subs,1:numel(subs),"uniformoutput",false);
	end
	ret=input(sub2ind(size(input),subs{:}));
	if options.pattern=="constant"
		ret(invalid)=options.fillvalue;
	end
	ret=reshape(ret,sz);
end