function mustBeInteger(self)
	arguments(Input)
		self dnm
	end
	try
		mustBeInteger(gather(self))
	catch ME
		rethrowAsCaller(ME)
	end
end