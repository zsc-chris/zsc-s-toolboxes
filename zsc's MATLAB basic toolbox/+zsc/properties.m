function [ret,attrtable]=properties(obj,available)
%zsc.properties	Improved version of MATLAB PROPERTIES.
%	[ret,attrtable]=zsc.properties(obj,available=true) allows to list all
%	properties, with their attributes.
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
				attrtable=table(string.empty(0,1),false(0,1),false(0,1),false(0,1),false(0,1),'VariableNames',["Name","Constant","Hidden","Readable","Writable"]);
			else
				disp(newline+"No class '"+obj+"'."+newline)
			end
			return
		end
	else
		classinfo=metaclass(obj);
	end
	properties=classinfo.PropertyList;
	attrtable=table(string({properties.Name}'),[properties.Constant]',[properties.Hidden]',strcmp({properties.GetAccess}','public'),strcmp({properties.SetAccess}','public'),'VariableNames',["Name","Constant","Hidden","Readable","Writable"]);
	if available
		attrtable=attrtable(~[properties.Hidden]'&strcmp({properties.GetAccess}','public'),:);
	end
	out=outclass;
	attrtable=attrtable(out{2,2,@sort,attrtable{:,1}},:);
	output={properties.Name}';
	output=attrtable{:,1};
	if nargout
		ret=cellstr(output);
	else
		if isempty(output)
			disp(newline+"No properties for class "+ifinline(isclass,@()obj,@()class(obj))+"."+newline)
		else
			output=char(string(char(output))+"	"+join(ternary(attrtable{:,2:4},zsc.cat(2,"Constant","Hidden",ternary(attrtable{:,5},"         ","Readonly ")),zsc.cat(2,"        ","      ",ternary(attrtable{:,5},"Writeonly","Private  "))),"	"));
			disp(newline+"Properties for class "+ifinline(isclass,@()obj,@()class(obj))+":"+newline)
			disp(output)
			disp(newline)
		end
	end
end