function [ret,Locb]=ismember(self,other,dims)
	arguments(Input)
		self dnm
		other dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	arguments(Output)
		ret dnm
		Locb dnm
	end
	[ret,Locb]=fevalalong(@zsc.ismember,dims,self,other,mode="flattenall",keepdims=true,additionalinput={"rows"});
end