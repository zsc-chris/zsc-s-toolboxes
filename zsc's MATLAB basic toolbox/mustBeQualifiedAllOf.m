function mustBeQualifiedAllOf(args)
	arguments(Input,Repeating)
		args
	end
	funsstr=args{end};
	args=args(1:end-1);
	funs=arrayfun(@(x)evalin("caller",x),funsstr,"uniformoutput",false);
	try
		for i=1:numel(funs)
			feval(funs{i},args{:})
		end
	catch
		error("MATLAB:validators:mustBeQualifiedAllOf","Argument(s) "+join(arrayfun(@(x)""""+x+"""",cellfun(@string,arrayfun(@inputname,1:numel(args),"uniformoutput",false))),", ")+" failed to pass all of the test(s) defined by "+join(arrayfun(@(x)""""+x+"""",funsstr),", ")+".")
	end
end