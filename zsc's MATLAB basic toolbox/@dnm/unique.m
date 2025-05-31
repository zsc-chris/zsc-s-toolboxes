function [ret,ia,ic]=unique(self,dims,setOrder)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		setOrder(1,1)string{mustBeMember(setOrder,["sorted","stable","first","last"])}="sorted"
	end
	arguments(Output)
		ret dnm
		ia dnm
		ic dnm
	end
	[ret,ia,ic]=fevalalong(@unique,dims,self,mode="flattenall",keepdims=true,keepotherdims=[true,false],additionalinput={"rows",setOrder});
end