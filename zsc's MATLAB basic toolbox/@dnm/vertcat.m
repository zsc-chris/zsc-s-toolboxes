function ret=vertcat(dnms)
	arguments(Input,Repeating)
		dnms
	end
	arguments(Output)
		ret dnm
	end
	ret=cat(1,dnms{:});
end