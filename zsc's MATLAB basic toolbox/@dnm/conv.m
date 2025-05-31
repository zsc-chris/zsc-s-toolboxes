function ret=conv(self,other,shape,options)
%CONV	Convolution for certain dimensions only
%	ret=CONV(self,other,shape,options.dims=1:ndims(self),precise=false)
%	Note that this algorithm use fftconv.
%
%	See also convn.

%	Copyright Chris H. Zhao 2025
	arguments(Input)
		self
		other
		shape(1,1)string{mustBeMember(shape,["full","same","valid"])}="full"
		options.dims(1,:){mustBeA(options.dims,["logical","double","string","char","cell"])}=1:ndims(self)
		options.precise(1,1)logical=false
	end
	arguments(Output)
		ret dnm
	end
	[self,other]=fevalalong(@deal,options.dims,self,other,keepdims=true,broadcastsizedims="other",vectorized=false);
	if ischar(options.dims)||iscellstr(options.dims)||isstring(options.dims)
		options.dims=string(options.dims);
	end
	if islogical(options.dims)
		options.dims=find(options.dims);
	end
	if isstring(options.dims)
		options.dims=index(self.dimnames,options.dims);
	end
	if options.precise
		ret=fevalalong(@convn,options.dims,self,other,keepdim=true,additionalinput={shape},broadcastsizedims="other",vectorized=false);
	else
		sz1=size(self,options.dims);
		sz2=size(other,options.dims);
		self=fft(self,paddata(sz1+sz2-1,2),options.dims);
		other=fft(other,paddata(sz1+sz2-1,2),options.dims);
		ret=ifft(self*other,paddata(sz1+sz2-1,2),options.dims);
		if shape=="same"
			ret=subsref(ret,substruct("()",{dictionary(self.dimnames(options.dims),arrayfun(@(dim,sz1,sz2){dnm((round((sz2-1)/2)+1:round((2*sz1+sz2-1)/2))',dim)},self.dimnames(options.dims),sz1,sz2))}));
		elseif shape=="valid"
			ret=subsref(ret,substruct("()",{dictionary(self.dimnames(options.dims),arrayfun(@(dim,sz1,sz2){dnm((min(sz1,sz2):max(sz1,sz2))',dim)},self.dimnames(options.dims),sz1,sz2))}));
		end
	end
end