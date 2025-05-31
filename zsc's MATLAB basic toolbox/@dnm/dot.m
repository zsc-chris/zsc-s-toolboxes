function dot(self,other,dims)
	arguments(Input)
		self
		other
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	fevalalong(@dot,dims,self,other,mode="flatten")
end