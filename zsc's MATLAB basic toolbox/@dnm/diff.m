function ret=diff(self,n,dims)
	arguments(Input)
		self dnm
		n{mustBeInteger,mustBePositive,mustBeTrue(n,"@(n)isscalar(n)||isequal(n,[])")}=[]
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	arguments(Output)
		ret dnm
	end
	if isequal(n,[])
		n=1;
	end
	ret=self.applyalong(@(x,dim)diff(x,n,dim),dims,mode="iterate",keepdims=true);
end