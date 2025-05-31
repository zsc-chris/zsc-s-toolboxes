function [F,TF]=fillmissingn(A,method,v,dim,options)
	arguments
		A
		method(1,1)
		v(1,:)double{mustBeInteger,mustBePositive}=ones(1,numel(size(A)))
		dim(1,:)double{mustBeInteger,mustBePositive}=ones(1,numel(size(A)))
		options.MissingLocations logical{mustBeEqualSize(options.MissingLocations,A)}=ternary(isa(A,"quaternion"),isnan(A),ismissing(A))
	end
	F=A;
	if isa(method,"function_handle")
	else
		method=string(method);
		switch(method)
			case "constant"
				F(options.MissingLocations)=v;
			case "nearest"
				[coords{:}]=ind2sub(size(A),find(options.MissingLocations));
				F(options.MissingLocations)=griddata(X,Y,double(A(~allMissingLocations)),xq,yq,method);
		end
	end
end