function S=str2subs(str)
	arguments(Input)
		str(1,1)string{mustBeTrue(str,"@(str)str==""""||regexp(str,""^[\.\(\{]"")")}
	end
	arguments(Output)
		S(1,:)struct
	end
	if str==""
		S=struct(type=cell(1,0),subs=cell(1,0));
	else
		varname=join([string(evalin("caller","who"));"a"],"");
		evalin("caller",varname+"=getsubsclass;")
		try
			S=evalin("caller",varname+str);
		catch ME
		end
		evalin("caller","clear "+varname)
		if exist("ME","var")
			rethrow(ME)
		end
	end
end