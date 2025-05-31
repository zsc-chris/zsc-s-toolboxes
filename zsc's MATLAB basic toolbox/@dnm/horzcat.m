function ret=horzcat(dnms)
	arguments(Input,Repeating)
		dnms
	end
	arguments(Output)
		ret dnm
	end
	ret=cat(2,dnms{:});
end