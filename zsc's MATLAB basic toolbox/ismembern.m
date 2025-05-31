function [Lia,Locb]=ismembern(A,B,flags)
	arguments(Input)
		A
		B
	end
	arguments(Input,Repeating)
		flags(1,1)string
	end
	arguments(Output)
		Lia
		Locb
	end
	[Lia,Locb]=ismember(arrayfun(@keyHash,A),arrayfun(@keyHash,B),flags{:});
end