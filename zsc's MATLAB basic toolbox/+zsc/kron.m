function K=kron(A,B)
%zsc.kron	Improved version of MATLAB KRON.
%	K=zsc.kron(A,B) can perform Kronecker product for tensors of any ndims.
	arguments(Input)
		A
		B
	end
	maxdim=max(ndims(A),ndims(B));
	szA=size(A,1:maxdim);
	szB=size(B,1:maxdim);
	A=reshape(A,flatten([ones([1,maxdim]);szA])');
	B=reshape(B,flatten([szB;ones([1,maxdim])])');
	K=reshape(A.*B,szA.*szB);
end