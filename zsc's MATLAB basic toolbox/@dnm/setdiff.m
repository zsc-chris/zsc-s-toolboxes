function [ret,ia]=setdiff(self,other,dims,setOrder)
	arguments(Input)
		self dnm
		other dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		setOrder(1,1)string{mustBeMember(setOrder,["sorted","stable"])}="sorted"
	end
	arguments(Output)
		ret dnm
		ia dnm
	end
	[ret,ia]=fevalalong(@setdiff,dims,self,other,mode="flattenall",keepdims=true,keepotherdims=[true,false],additionalinput={"rows",setOrder});
end