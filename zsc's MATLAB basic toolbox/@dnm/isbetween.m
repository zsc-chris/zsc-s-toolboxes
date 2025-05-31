function ret=isbetween(self,lower,upper,intervalType)
	arguments(Input)
		self dnm
		lower dnm{mustBeNumeric}
		upper dnm{mustBeNumeric}
		intervalType(1,1)string{mustBeMember(intervalType,["closed","open","openleft","openright","closedright","closedleft"])}="closed"
	end
	arguments(Output)
		ret dnm
	end
	ret=feval(@isbetween,self,lower,upper,additionalinput={intervalType});
end