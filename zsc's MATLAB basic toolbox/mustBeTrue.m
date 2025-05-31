function mustBeTrue(args)
%	Note: cannot access private method. If you want to do so, the string
%	arguments can be changed to function, with you defining an alias for
%	eval and use that to convert string into function handle in the
%	original function.
	arguments(Input,Repeating)
		args
	end
	condstr=args{end};
	cond=str2func(condstr);
	args=args(1:end-1);
	zsc.assert(cond(args{:}),"MATLAB:validators:mustBeTrue","Argument(s) "+join(arrayfun(@(x)""""+x+"""",cellfun(@string,arrayfun(@inputname,1:numel(args),"uniformoutput",false))),", ")+" failed to meet the condition defined by """+condstr+""".");
end