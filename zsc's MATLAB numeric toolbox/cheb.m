function [D,x]=cheb(N,L)
	arguments
		N(1,1)
		L(1,1)=2
	end
	if isgpuarray(N)
		if N==0
			[D,x]=deal(gpuArray(0),gpuArray(1));
			return
		end
		[x,c]=deal(cospi(gpuArray(0:N)/N)',[2;gpuArray(ones(N-1,1));2].*(-1).^(0:N)');
	else
		if N==0
			[D,x]=deal(0,1);
			return
		end
		[x,c]=deal(cospi((0:N)/N)',[2;ones(N-1,1);2].*(-1).^(0:N)');
	end
	X=repmat(x,1,N+1);
	dX=X-X';
	D=(c*(1./c)')./(dX+(eye(N+1)));
	D=D-diag(sum(D,2));
	[D,x]=deal(D.*2./L,x./2.*L);
end
