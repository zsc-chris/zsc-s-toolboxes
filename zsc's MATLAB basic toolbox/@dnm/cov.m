function ret=cov(self,other,w,dims,nanflag)
	arguments(Input)
		self
		other
		w(1,1)double{mustBeMember(w,[0,1])}=1
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=2
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitrows","partialrows"])}="includemissing"
	end
	arguments(Output)
		ret dnm
	end
	ret=fevalalong(@cov_,dims,self,other,mode="flattenall",keepdims=false,keepotherdims=true,additionalinput={w,nanflag});
end
function ret=cov_(self,other,w,nanflag)
	arguments(Input)
		self
		other
		w(1,1)double{mustBeMember(w,[0,1])}=0
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitrows","partialrows"])}="includemissing"
	end
	tmp=[self,other];
	if size(tmp,1)==1
		ret=ifinline(w==0,@()nan(size(self),"like",self),@()ternary(isfinite(self),0,nan));
		return
	end
	ret=cov(tmp,w,nanflag);
	ret=diag(ret(1:end/2,end/2+1:end))';
end