function output=succeeds(command,input1,input2)
%SUCCEEDS	Test if command is successful.
%	output=SUCCEEDS(command,input1,input2) returns input1 if command runs
%	successfully, otherwise input2.
%
%	This is useful in the case you are validating any kind of input, and
%	some conversion may fail. For example,
%	zsc.assert(string(a)=="a","b") errors without the message "b" if a is
%	not convertible to string, but
%	zsc.assert(succeeds(@()assert(string(a)=="a")),"b") is guaranteed to
%	error with the message "b".
%
%	See also ternary, ifinline, tryinline.

%	Copyright 2025 Chris H. Zhao
	arguments
		command(1,1)function_handle
		input1=true
		input2=false
	end
	try
		command()
		output=input1;
	catch
		output=input2;
	end
end