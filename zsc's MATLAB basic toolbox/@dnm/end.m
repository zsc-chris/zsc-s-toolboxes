function ret=end(self,k,n)
	arguments(Input)
		self dnm
		k(1,:)double{mustBeInteger,mustBePositive}
		n(1,1)double{mustBeInteger,mustBePositive}
	end
	arguments(Output)
		ret double{mustBeInteger,mustBeNonnegative}
	end
	if k<n
		ret=size(self,k);
	else
		ret=prod(size(self,k:ndims(self)));
	end
end