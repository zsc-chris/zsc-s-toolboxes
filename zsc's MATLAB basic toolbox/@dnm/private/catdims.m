function dim=catdims(dims)
	arguments(Input)
		dims(1,:)string
	end
	arguments(Output)
		dim(1,:)string
	end
	dim=join(dims,"×");
end