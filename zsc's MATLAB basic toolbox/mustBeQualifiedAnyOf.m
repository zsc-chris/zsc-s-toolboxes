function mustBeQualifiedAnyOf(args)
	arguments(Input,Repeating)
		args
	end
	funsstr=args{end};
	args=args(1:end-1);
	flag=false;
	funs=arrayfun(@str2func,funsstr,"uniformoutput",false);
	for i=1:numel(funs)
		try
			feval(funs{i},args{:});
			flag=true;
		end
	end
	zsc.assert(flag,"MATLAB:validators:mustBeQualifiedAllOf","Argument(s) "+join(arrayfun(@(x)""""+x+"""",cellfun(@string,arrayfun(@inputname,1:numel(args),"uniformoutput",false))),", ")+" failed to pass any of the test(s) defined by "+join(arrayfun(@(x)""""+x+"""",funsstr),", ")+".")
end