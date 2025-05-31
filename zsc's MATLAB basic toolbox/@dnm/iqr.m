function [ret,q]=iqr(self,dims)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	[ret,q]=applyalong(self,@iqr,dims,mode="flatten",keepdims=[false,true]);
end