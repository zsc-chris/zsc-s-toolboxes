function f=prevreal(x)
%PREVREAL	Previous real floating-point number
%	f=PREVREAL(x) returns the immediate predecessor in float set of each
%	value in x.
%
%	See also nextreal, eps, neps
	if x<0
		f=x-eps(x);
	else
		f=x-neps(x);
	end
end