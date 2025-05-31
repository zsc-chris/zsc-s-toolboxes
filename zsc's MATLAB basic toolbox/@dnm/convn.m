function ret=convn(self,other,shape,options)
	arguments(Input)
		self
		other
		shape(1,1)string{mustBeMember(shape,["full","same","valid"])}="full"
		options.precise(1,1)logical=false
	end
	arguments(Output)
		ret dnm
	end
	if options.precise
		ret=feval(@convn,self,other,additionalinput={shape},broadcastsize=false);
	else
		ret=feval(@fftconvn,self,other,additionalinput={shape},broadcastsize=false);
	end
end