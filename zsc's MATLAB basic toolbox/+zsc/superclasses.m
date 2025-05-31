function [ret,attrtable]=superclasses(obj,available)
%zsc.superclasses	Improved version of MATLAB SUPERCLASSES.
%	[ret,attrtable]=zsc.superclasses(obj,available=true) allows to list all
%	superclasses, with their attributes.
	arguments
		obj
		available=true
	end
	isclass=isa(obj,"char")||isa(obj,"string");
	if isclass
		classinfo=matlab.metadata.Class.fromName(obj);
		if isempty(classinfo)
			if nargout
				ret=cell(0,1);
				attrtable=table(string.empty(0,1),false(0,1),false(0,1),false(0,1),false(0,1),false(0,1),'VariableNames',["Name","Hidden","Abstract","Enumeration","HandleCompatible","RestrictsSubclassing"]);
			else
				disp(newline+"No class '"+obj+"'."+newline)
			end
			return
		end
	else
		classinfo=metaclass(obj);
	end
	superclasses=classinfo.SuperclassList;
	attrtable=table(string({superclasses.Name}'),[superclasses.Hidden]',[superclasses.Abstract]',[superclasses.Enumeration]',[superclasses.HandleCompatible]',[superclasses.RestrictsSubclassing]','VariableNames',["Name","Hidden","Abstract","Enumeration","HandleCompatible","RestrictsSubclassing"]);
	if available
		attrtable=attrtable(~[superclasses.Hidden]',:);
	end
	out=outclass;
	attrtable=attrtable(out{2,2,@sort,attrtable{:,1}},:);
	output={superclasses.Name}';
	output=attrtable{:,1};
	if nargout
		ret=cellstr(output);
	else
		if isempty(output)
			disp(newline+"No superclasses for class "+ifinline(isclass,@()obj,@()class(obj))+"."+newline)
		else
			output=char(string(char(output))+"	"+join(ternary(attrtable{:,2:6},["Hidden","Abstract","Enumeration","HandleCompatible","RestrictSubclassing"],["      ","        ","           ","                ","                   "]),"	"));
			disp(newline+"superclasses for class "+ifinline(isclass,@()obj,@()class(obj))+":"+newline)
			disp(output)
			disp(newline)
		end
	end
end