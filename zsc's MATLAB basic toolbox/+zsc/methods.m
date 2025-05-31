function [ret,attrtable]=methods(obj,available)
%zsc.methods	Improved version of MATLAB METHODS.
%	[ret,attrtable]=zsc.methods(obj,available=true) allows to list all
%	methods, with their attributes.
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
				attrtable=table(string.empty(0,1),false(0,1),false(0,1),false(0,1),false(0,1),false(0,1),'VariableNames',["Name","Static","Abstract","Sealed","Hidden","Public"]);
			else
				disp(newline+"No class '"+obj+"'."+newline)
			end
			return
		end
	else
		classinfo=metaclass(obj);
	end
	methods=classinfo.MethodList;
	attrtable=table(string({methods.Name}'),[methods.Static]',[methods.Abstract]',[methods.Sealed]',[methods.Hidden]',strcmp({methods.Access}','public'),'VariableNames',["Name","Static","Abstract","Sealed","Hidden","Public"]);
	if available
		attrtable=attrtable(~[methods.Hidden]'&strcmp({methods.Access}','public'),:);
	end
	out=outclass;
	attrtable=attrtable(out{2,2,@sort,attrtable{:,1}},:);
	output=attrtable{:,1};
	if nargout
		ret=cellstr(output);
	else
		if isempty(output)
			disp(newline+"No methods for class "+ifinline(isclass,@()obj,@()class(obj))+"."+newline)
		else
			output=char(string(char(output))+"	"+join(ternary(attrtable{:,2:6},["Static","Abstract","Sealed","Hidden","       "],["      ","        ","      ","      ","Private"]),"	"));
			disp(newline+"Methods for class "+ifinline(isclass,@()obj,@()class(obj))+":"+newline)
			disp(output)
			disp(newline)
		end
	end
end