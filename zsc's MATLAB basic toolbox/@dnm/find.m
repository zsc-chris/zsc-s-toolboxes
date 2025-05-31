function [ret,nonzeros]=find(self,n,dims,options)
	arguments(Input)
		self dnm
		n double{mustBeTrue(n,"@(n)isequal(n,[])||n>=0&&succeeds(@()mustBeInteger(n))")}=[]
		dims(1,:){mustBeA(dims,["double","string","char","cell"])}=1:ndims(self)
		options.direction(1,1)string{mustBeMember(options.direction,["first","last"])}="first"
	end
	arguments(Output)
		ret dnm
		nonzeros dnm
	end
	out=outclass;
	if isequal(n,0)
		ret=applyalong(self,@(self)repmat(self,[0,1]),dims,mode="flatten",keepdims=true,vectorized=false);
		nonzeros=ret;
	else
		[ret,~,nonzeros]=applyalong(self,@find,dims,mode="flatten",keepdims=true,additionalinput=ifinline(isequal(n,[]),@(){},@(){n,options.direction}),vectorized=false);
	end
end