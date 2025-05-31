function B=subsref(self,S)
%SUBSREF	Indexed reference that allows you to group dimensions.
%	Syntax: *...=...[.(...)/(...)/{...}]*?
%
%	. Usage: properties & methods of self are priortized over properties /
%		fields / methods of self.value
%
%	() Usage: Supports these syntax:%
%		...(dim1={sub1,sub2},dim1={...},dim1=indn2ndims,dim2=sub2,...)...->
%			Each sub (if not cell, convert to cell) will be grouped by cat
%			according to the provided dimension, and subs in a group, if
%			not a dnm, will be converted to dnm using the 1, 2, ...,
%			n–ndims (the ndims of the group). If sub is ':' it will be
%			replaced with (1:end)' before broadcasting. If sub is logical
%			it will be find-ed before broadcasting. Then arrays within a
%			group will be broadcast against each other and sub2ind-ed. 
%			Dimensions not referenced will be filled with ':'.
%
%		...(sub1,sub2,...,indn2ndims)...->same as
%			...(catdims(self.dimnames),{sub1,sub2,...,indn2ndims}), see
%			above
%
%		...(ind(1,1)struct/dictionary/table(dim1=sub1,dim2=sub2))...->First
%			dstar{ind}, and then same as the above semantics.
%
%		You may use ...(...,newdim1=':',newdim2=':',...) to add dimensions,
%		although in most cases this is unnecessary.
%
%	{} Usage: Same as (), but for dtype=cell. See starclass if you want to
%		unzip.
%
%	Using a×b as reference will prioritize a×b over a and b if they
%	all exist in dimension.
%
%	Example: 
%	>> [aind,cind]=ndgrid(dnm(1:2,"a"),dnm(1:2,"c"));
%	>> [bind,dind]=ndgrid(dnm(1:2,"b"),dnm(1:2,"d"));
%	>> a=dnm(reshape(1:16,2,2,2,2),["a","b","c","d"]);
%	>> a(aind,bind,cind,dind)
%	>> all(a(aind,bind,cind,dind)==a)
%
%	ans =
%
%	  dnm logical scalar
%
%	   1
%
%	>> all(a("a×c",{aind,cind},"b×d",{bind,dind})==a)
%
%	ans =
%
%	  dnm logical scalar
%
%	   1
%
%	Note: To input ×, install powertoys, press-and-hold x and press space,
%	press ← key, and finally release x. I am sorry that this is annoying.
%
%	See also dnm/subsasgn, dnm/ndgrid, starclass

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
		S(:,1)struct
	end
	arguments(Output,Repeating)
		B
	end
	if S(1).type=="."
		if zsc.isproperty("dnm",S(1).subs)||zsc.ismethod("dnm",S(1).subs)||zsc.ismethod("dnm",S(1).subs,false)&&zsc.ismethod("dnm",S(1).subs+"_")
			[B{1:nargout}]=subsref@dotprivate(self,S);
		else
			[B{1:nargout}]=subsref(self.value,S);
		end
	else
		star=starclass;
		[~,subs]=parsedimargsindexing(self,S(1).subs,"subsref");
		if isempty(subs)
			B={self};
			return
		end
		for i=1:size(subs,2)
			if ~ismembern(subs{1,i},[self.dimnames,missing])
				self=flatten(self,splitdim(subs{1,i}));
			end
		end
		dims=zsc.cell2mat(subs(1,:));
		S(1).subs=arrayfun(@(dim)ifinline(ismembern(dim,dims),@()subs{2,eqn(dim,dims)},@()':'),[self.dimnames,missing],"uniformoutput",false);
		newsize=[star{arrayfun(@(dim)ifinline(ismembern(dim,dims),@()subs{3,eqn(dim,dims)},@()size(self,dim)),[self.dimnames,missing],"uniformoutput",false),2}{:}];
		newdimnames=[star{arrayfun(@(dim)ifinline(ismembern(dim,dims),@()splitdim(dim,numel(subs{3,eqn(dim,dims)})),@()dim),[self.dimnames,missing],"uniformoutput",false),2}{:}];
		if S(1).type=="()"
			[B{1:nargout}]=zsc.subsref(dnm(reshape(subsref(self.value,S(1)),paddata(newsize,[1,2],"fillvalue",1)),newdimnames),S(2:end));
		else
			[B{1:nargout}]=subsref(self.value,S);
			if ~ismember("{}",cellfun(@(x)string(x),{S.type}))&&~ismember(".",cellfun(@(x)string(x),{S.type}))
				B=cellfun(@(x)dnm(reshape(x,paddata(newsize,[1,2],"fillvalue",1)),newdimnames),B,"uniformoutput",false);
			end
		end
	end
end