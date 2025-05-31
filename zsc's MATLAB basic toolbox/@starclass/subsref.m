function B=subsref(self,S)
	arguments(Input)
		self starclass
		S(:,1)struct
	end
	arguments(Output,Repeating)
		B
	end
	if S(1).type=="."
		[B{1:nargout}]=builtin("subsref",self,S);
		return
	else
		S(1).subs=paddata(S(1).subs,2,"fillvalue",{1});
		sz=size(S(1).subs{1},1:max(ndims(S(1).subs{1}),max(paddata(S(1).subs{2},1))));
		inds=setdiff(1:numel(sz),S(1).subs{2});
		if ~isa(S(1).subs{1},"dnm")
			B=zsc.squeeze(cellfun(@(x)zsc.squeeze(x,S(1).subs{2}),zsc.num2cell(S(1).subs{1},inds),"uniformoutput",false),inds);
		else
			B=num2cell(S(1).subs{1},inds);
		end
		if ~isscalar(S)
			B=cellfun(@(x)subsref(x,S(2:end)),B,"uniformoutput",false);
		end
		if S(1).type=="()"
			B={B};
		end
	end
	if isa(B,"dnm")
		B=gather(B);
	end
end