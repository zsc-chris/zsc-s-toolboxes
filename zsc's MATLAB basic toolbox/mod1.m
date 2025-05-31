function ret=mod1(x,y)
%mod1	Modulo in [1,divisor].
%	mod1(x,y) returns a value in the range [1,divisor] insdead of
%	[0,divisor-1] as the modulo. It may be used to generate matlab index
%	which starts with 1.
%
%	See also mod, rem

%	Copyright 2023 Chris H. Zhao
	ret=mod(x-1,y)+1;
end