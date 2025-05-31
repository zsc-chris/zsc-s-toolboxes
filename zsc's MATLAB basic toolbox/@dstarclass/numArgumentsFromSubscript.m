function ret=numArgumentsFromSubscript(self,s,indexingContext)
%	If the object being subsasgned does not exist, it defaults to 2.
%	To change this behavior, subclass this class as a handle class and use
%	an attribute.
	arguments
		self dstarclass
		s(:,1)struct
		indexingContext(1,1)matlab.indexing.IndexingContext
	end
	switch s(1).type
		case "."
			ret=builtin("numArgumentsFromSubscript",self,s,indexingContext);
		case "{}"
			if indexingContext==matlab.indexing.IndexingContext.Assignment
				if numel(s(1).subs)>=2
					ret=s(1).subs{2}*2;
					return
				end
				try
					s(1).subs={evalin("caller",s(1).subs{1})};
					ret=numArgumentsFromSubscript(self,s,matlab.indexing.IndexingContext.Expression);
				catch
					ret=2;
				end
			else
				mapping=s(1).subs{1};
				if isa(mapping,"table")
					if size(mapping,2)==2&&(iscellstr(mapping{:,1})||iscellstr(mapping{:,2}))
						ret=numel(mapping);
					else
						ret=numel(mapping)*2;
					end
				elseif isa(mapping,"dictionary")
					ret=mapping.numEntries*2;
				elseif isa(mapping,"struct")
					ret=numel(fieldnames(mapping))*2;
				end
			end
		case "()"
			ret=1;
	end
end