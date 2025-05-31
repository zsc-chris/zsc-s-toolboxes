function ret=repr(x,from)
%REPR	String representation of object.
%	REPR(x,from) returns string representation of x. REPR(x,"disp") is
%	idempotent and an alias for formattedDisplayText. REPR(x,"display") is
%	not idempotent but contains more information.
%
%	See also mat2str, disp, display, formattedDisplayText

%	Copyright 2024 Chris H. Zhao
	arguments(Input)
		x
		from(1,1)string{mustBeMember(from,["disp","display"])}="display"
	end
	if from=="display"
		ret=evalc("display(x,'')");
	else
		ret=formattedDisplayText(x,"suppressmarkup",~desktop("-inuse"));
	end
	if ~isempty(ret)&&ret(end)==newline
		ret=ret(1:end-1);
	end
	ret=string(ret);
end