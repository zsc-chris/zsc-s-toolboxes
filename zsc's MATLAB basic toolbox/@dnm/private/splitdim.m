function dims=splitdim(dim,n)
	arguments(Input)
		dim(1,:)string{mustBeTrue(dim,"@(dim)numel(dim)<=1")}
		n(1,1)double=count(dim,"×")+1
	end
	arguments(Output)
		dims(1,:)string
	end
	if ismissing(dim)
		dims="x"+string(1:n);
	else
		dims=split(dim,"×")';
		if numel(dims)>n
			dims(n)=catdims(dims(n:numel(dims)));
			dims(n+1:end)=[];
		else
			dims=[dims,"x"+string(numel(dims)+1:n)];
		end
	end
end