function ret=keyHash(~)
	arguments(Input)
		~
	end
	arguments(Output)
		ret uint64
	end
	error("DNM:array:InvalidDictionaryKey","Invalid value type dnm specified for dictionary key.")
end