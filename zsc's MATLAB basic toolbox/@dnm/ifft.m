function ret=ifft(self,n)
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		n(1,:)
	end
	arguments(Output)
		ret dnm
	end
	n=paddata(n,1,fillvalue={self.dimnames});
	if isscalar(n)
		if ischar(n{1})||iscellstr(n{1})||isstring(n{1})
			n=num2cell(string(n{1}));
			n(2,:)=num2cell(size(self,zsc.cell2mat(n)));
			n=n(:);
		end
	end
	n=parsedimargs(self.dimnames,n);
	zsc.assert(isempty(n)||isequal(sort(zsc.cell2mat(n(1,:))),unique(zsc.cell2mat(n(1,:)))),"DNM:RepeatedDimension","Repeated dimension not allowed.")
	ret=self.applyalong(@ifft_,zsc.cell2mat(n(1,:)),keepdims=true,additionalinput={zsc.cell2mat(n(2,:))});
end
function self=ifft_(self,dims,n)
	for i=1:numel(dims)
		self=ifft(self,n(i),dims(i));
	end
end
