function self=subsasgn(self,S,B)
	arguments(Input)
		self starclass
		S(1,:)struct
	end
	arguments(Input,Repeating)
		B
	end
	arguments(Output)
		self starclass
	end
	if S(1).type=="."
		self=builtin("subsasgn",self,S,B{:});
		return
	end
	S(1).subs{1}=string(S(1).subs{1});
	[ind,name]=regexp(S(1).subs{1},"^[^.^\(\{]*","end","match");
	S(1).subs=paddata(S(1).subs,2,"fillvalue",{1});
	dims=S(1).subs{2};
	subs=extractBetween(S(1).subs{1},ind+1,strlength(S(1).subs{1}));
	S_=evalin("caller","str2subs("""+subs+""")");
	if isempty(S_)||S_(end).type~="()"
		try
			var=evalin("caller",name);
			varsubs=zsc.subsref(var,S_);
			S_=[S_,substruct("()",repmat({':'},1,max(max(dims),ndims(varsubs))))];
		catch
			S_=[S_,substruct("()",repmat({':'},1,max(dims)))];
		end
	else
		try
			var=evalin("caller",name);
			varsubs=zsc.subsref(var,S_(1:end-1));
		end
	end
	iscolon=cellfun(@(x)isequal(x,':'),S_(end).subs(dims));
	sz=arrayfun(@(x,y)ifinline(y,@()[],@()numel(x{:})),S_(end).subs(dims),iscolon,"uniformoutput",false);
	if S(1).type=="()"
		B=B{:};
		sz=cell2mat(ternary(iscolon,num2cell(size(B,1:numel(dims))),sz));
		zsc.assert(isequal(sz,size(B,1:numel(dims))),message("MATLAB:subsassigndimmismatch"));
	else
		if nnz(iscolon)>1
			if exist("varsubs","var")
				sz(find(iscolon,nnz(iscolon)-1))=num2cell(size(varsubs,dims(find(iscolon,nnz(iscolon)-1))));
			else
				throwAsCaller(MException(message("MATLAB:indexed_matrix_cannot_be_resized")))
			end
		end
		B=reshape(B,sz{:},1,1);
		sz=size(B,1:numel(dims));
	end
	ind=arrayfun(@(x,y)ifinline(isequal(y{:},':'),@()(1:x)',@()sort(flatten(y{:}))),sz,S_(end).subs(dims),"uniformoutput",false);
	[ind{:}]=ndgrid(ind{:});
	ind=cellfun(@flatten,ind,"uniformoutput",false);
	ind=num2cell(cell2mat(ind));
	if ~exist("var","var")
		var=[];
	end
	for i=size(ind,1):-1:1
		S__=S_;
		S__(end).subs(dims)=ind(i,:);
		out=outclass;
		if ~exist("varsubs","var")
			tmp=zsc.squeeze(zsc.subsref(zsc.subsasgn(var,S__,0),S__),S(1).subs{2});
			nAFS=zsc.numArgumentsFromSubscript([],S(2:end),matlab.indexing.IndexingContext.Assignment,size=size(tmp));
			varB=zsc.unsqueeze(zsc.subsasgn([],S(2:end),out{nAFS,1:nAFS,@deal,B{i}},size=size(tmp)),S(1).subs{2});
			try
				var=zsc.subsasgn(var,S__,varB);
			catch
				if isempty(varB)
					var=zsc.subsasgn(var,S__,[]);
				else
					S___=S__;
					S___(end).subs=ternary(arrayfun(@(x)isequal(x,{':'}),S__(end).subs),arrayfun(@(x){1:size(varB,x)},1:numel(S__(end).subs)),S__(end).subs);
					var=zsc.subsasgn(var,S___,varB);
				end
			end
			varsubs=zsc.subsref(var,S_(1:end-1));
		else
			varsubs_=zsc.subsasgn(varsubs,S__(end),createArray(1,1,"like",varsubs));
			tmp=zsc.squeeze(zsc.subsref(paddata(varsubs,size(varsubs_)),S__(end)),S(1).subs{2});
			nAFS=zsc.numArgumentsFromSubscript(tmp,S(2:end),matlab.indexing.IndexingContext.Assignment);
			varB=zsc.unsqueeze(zsc.subsasgn(tmp,S(2:end),out{nAFS,1:nAFS,@deal,B{i}}),S(1).subs{2});
			try
				var=zsc.subsasgn(var,S__,varB);
			catch
				if isempty(varB)
					var=zsc.subsasgn(var,S__,[]);
				else
					S___=S__;
					S___(end).subs=ternary(arrayfun(@(x)isequal(x,{':'}),S__(end).subs),arrayfun(@(x){1:size(varB,x)},1:numel(S__(end).subs)),S__(end).subs);
					var=zsc.subsasgn(var,S___,varB);
				end
			end
		end
	end
	assignin("caller",name,var)
end