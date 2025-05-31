function ret=sum(self,dims,nanflag)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
		nanflag(1,1)string{mustBeMember(nanflag,["includemissing","includenan","omitmissing","omitnan"])}="includemissing"
	end
	arguments(Output)
		ret dnm
	end
	if ~isUnderlyingType(self,"string")
		ret=self.applyalong(@sum,dims,additionalinput={nanflag});
	else
		if contains(nanflag,"include")
			ret=join(self,"",dims);
		else
			self.value(ismissing(self.value))="";
			ret=join(self,"",dims);
		end
	end
end