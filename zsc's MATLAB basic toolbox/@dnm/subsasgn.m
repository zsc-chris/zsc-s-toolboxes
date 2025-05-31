function self=subsasgn(self,S,B)
%SUBSASGN	Indexed assignment that allows you to group dimensions.
%	Syntax: [...[.(...)/(...)/{...}]*?]=*... For complete description see
%	<a href="matlab:help dnm/subsref -displayBanner">dnm/subsref</a>.
%
%	Note: parenDelete is not supported, as MATLAB's rule of deletion is
%	rather unclear.
%
%	See also dnm/subsref
	arguments(Input)
		self dnm
		S(1,:)struct
	end
	arguments(Input,Repeating)
		B
	end
	arguments(Output)
		self dnm
	end
	if S(1).type=="."
		if zsc.isproperty("dnm",S(1).subs)
			self=builtin("subsasgn",self,S,B{:});
		else
			self=builtin("subsasgn",self.value,S,B{:});
		end
	else
		[self,subs]=parsedimargsindexing(self,S(1).subs,"subsasgn");
		if isscalar(S)&&S(1).type=="()"&&isequal(B,{[]})
			error("DNM:subsasgn:parenDeletenotsupported","Parenthesis deletion ...(...)=[] is not supported because its rule is too bugged.")
		else
			ind=dnm(zsc.reshape(1:numel(self),size(self)),self.dimnames);
			S_=S(1);
			S_.type="()";
			ind=subsref(ind,S_).value;
			if S(1).type=="()"
				ret=subsref(self,S_);
				for i=1:numel(B)
					if isa(B{i},"dnm")
						[~,B{i}]=feval(@deal,ret,squeeze(B{i},setdiff(ret.dimnames,B{i}.dimnames)));
						B{i}=B{i}.value;
					end
				end
				S_=S(2:end);
				if isempty(S_)
					ret.value=B{:};
				else
					try
						subsref(ret,S_,"dnmonly");
						ret=builtin("subsasgn",ret,S_,B{:});
					catch
						ret=builtin("subsasgn",ret.value,S_,B{:});
					end
				end
				self.value(ind)=ret.value;
			else
				ret=subsref(self,S_).value;
				S_=S;
				S_(1).subs=repmat({':'},[1,ndims(ret)]);
				ret=subsasgn(ret,S_,B{:});
				self.value(ind)=ret;
			end
		end
	end
end