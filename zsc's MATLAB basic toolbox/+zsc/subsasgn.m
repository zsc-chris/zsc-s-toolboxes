function A=subsasgn(A,S,B,options)
%zsc.subsasgn	Improved version of MATLAB SUBSASGN.
%	A=zsc.subsasgn(A,S,*B,size=[]) can subsasgn new object by setting A to
%	[] (with a preset size to tolerate situations like [a{:}]=deal(1)), and
%	can tolerate when S is empty.
	arguments(Input)
		A
		S(1,:)struct
	end
	arguments(Input,Repeating)
		B
	end
	arguments(Input)
		options.size(1,:)
	end
	if isempty(S)
		A=B{:};
		return
	end
	if isequal(A,[])
		if isfield(options,"size")
			switch S(1).type
				case "()"
					if isscalar(S)
						A=subsasgn(createArray(options.size,"like",B{:}),S,B{:});
					else
						A=subsasgn(createArray(options.size,"struct"),S,B{:});
					end
				case "{}"
					A=subsasgn(createArray(options.size,"cell"),S,B{:});
				case "."
					A=subsasgn(createArray(options.size,"struct"),S,B{:});
			end
		else
			if isscalar(S)&&S.type=="()"
				clear A
				A(S.subs{:})=B{:};
			else
				A=subsasgn(A,S,B{:});
			end
		end
	else
		try
			A=subsasgn(A,S,B{:});
		catch ME
			if ME.identifier=="MATLAB:heterogeneousStrucAssignment"
				tmp=zsc.subsref(A,S(1:end-1));
				for i=string(fieldnames(B{:}))'
					if isfield(tmp,i)
						tmp_=arrayfun(@(x){x.(i)},tmp);
					else
						tmp_=arrayfun(@(x){[]},tmp);
					end
					tmp_=subsasgn(tmp_,S(end),arrayfun(@(x){x.(i)},B{:}));
					tmp=paddata(tmp,size(tmp_));
					[tmp.(i)]=tmp_{:};
				end
				A=zsc.subsasgn(A,S(1:end-1),tmp);
			else
				rethrow(ME)
			end
		end
	end
end