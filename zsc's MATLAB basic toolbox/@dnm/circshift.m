function ret=circshift(self,K)
%CIRCSHIFT	Shift positions of elements circularly.
%	ret=CIRCSHIFT(self,*K), K can be *(dims=K), K, or *K.
%
%	See also circshift

%	Copyright 2025 Chris H. Zhao
	arguments(Input)
		self dnm
	end
	arguments(Input,Repeating)
		K(1,:)
	end
	zsc.assert(~isempty(K),message("MATLAB:minrhs"))
	K=parsedimargs(self.dimnames,K);
	zsc.assert(isempty(K)||isequal(sort(zsc.cell2mat(K(1,:))),unique(zsc.cell2mat(K(1,:)))),"DNM:RepeatedDimension","Repeated dimension not allowed.")
	ret=self.applyalong(@circshift_,zsc.cell2mat(K(1,:)),keepdims=true,additionalinput=zsc.cell2mat(K(2,:),[],false));
end
function self=circshift_(self,dims,K)
	for i=1:numel(dims)
		self=circshift(self,K(i),dims(i));
	end
end