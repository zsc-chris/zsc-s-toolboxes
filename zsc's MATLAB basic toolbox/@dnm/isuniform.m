function [ret,step]=isuniform(self,dims)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	arguments(Output)
		ret dnm
		step(1,1)struct
	end
	if ischar(dims)||iscellstr(dims)||isstring(dims)
		dims=string(dims);
	end
	if islogical(dims)
		dims=find(dims);
	end
	if isnumeric(dims)
		dims=[self.dimnames(1:min(ndims(self),numel(dims))),"x"+string(ndims(self)+1:numel(dims))];
	end
	ret=dnm(true(paddata(size(self),2,fillvalue=1)),self.dimnames);
	ret.dimnames(index(ret.dimnames,dims))=missing;
	step=struct();
	for i=dims
		[reti,sizei]=applyalong(self,@isuniform,i,vectorized=false);
		reti=all(reti,dims(dims~=i));
		isuniformi=fevalalong(@(self)isscalar(uniquetol(self,4*eps)),dims(dims~=i),sizei,mode="flatten",broadcastsizedims="other",vectorized=false);
		ret=ret&reti&isuniformi;
		step.(i)=mean(sizei,dims(dims~=i));
		step.(i).value(~gather(isuniformi))=nan;
	end
end