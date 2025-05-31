function ret=eqn(A,B)
%EQN	Treat missing as equal.
	ret=arrayfun(@keyHash,A)==arrayfun(@keyHash,B);
end