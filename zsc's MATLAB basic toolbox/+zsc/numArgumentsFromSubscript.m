function n=numArgumentsFromSubscript(obj,s,indexingContent,options)
%zsc.numArgumentsFromSubscript	Improved version of MATLAB numArgumentsFromSubscript.
%	n=zsc.numArgumentsFromSubscript(obj,s,indexingContent,*,size) can get
%	numArgumentsFromSubscript of new object by setting A to [] and setting
%	a preset size, and can tolerate when S is empty.
	arguments(Input)
		obj
		s(1,:)struct
		indexingContent(1,1)matlab.indexing.IndexingContext
		options.size(1,:)
	end
	if isempty(s)
		n=1;
		return
	end
	if indexingContent==matlab.indexing.IndexingContext.Assignment&&isequal(obj,[])&&isfield(options,"size")
		switch s(1).type
			case "()"
				if isscalar(s)
					n=1;
				else
					n=numArgumentsFromSubscript(createArray(options.size,"struct"),s,indexingContent);
				end
			case "{}"
				n=numArgumentsFromSubscript(createArray(options.size,"cell"),s,indexingContent);
			case "."
				n=numArgumentsFromSubscript(createArray(options.size,"struct"),s,indexingContent);
		end
	else
		n=numArgumentsFromSubscript(obj,s,indexingContent);
	end
end