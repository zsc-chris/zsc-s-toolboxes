function TF=isdnm(X)
	arguments(Input)
		X
	end
	arguments(Output)
		TF(1,1)logical
	end
	TF=isa(X,"dnm");
end