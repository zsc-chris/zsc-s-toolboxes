function C=cat(dim,A)
%zsc.cat	Improved version of MATLAB CAT.
%	C=zsc.cat(dim,*A) auto broadcasts arrays in A before concatenating.
	arguments(Input)
		dim(1,1)double{mustBePositive,mustBeInteger}
	end
	arguments(Input,Repeating)
		A
	end
	arguments(Output)
		C
	end
	maxndims=max(cellfun(@(x)ndims(x),A));
	sz=cellfun(@(x)size(x,1:maxndims),A,"uniformoutput",false);
	sz_=cell2mat(sz');
	sz_(sz_==1)=nan;
	maxdim=fillmissing(max(sz_,[],1),constant=1);
	r=cellfun(@(x,y)fillmissing(ternary(1:maxndims==dim,ones(1,maxndims),maxdim./y),constant=1),A,sz,"uniformoutput",false);
	A=cellfun(@repmat,A,r,"uniformoutput",false);
	C=cat(dim,A{:});
end