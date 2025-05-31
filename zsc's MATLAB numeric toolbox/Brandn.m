function varargout=Brandn(varargin)
%Brandn(sz) Better randn
%	Plot the histogram of Brandn's result
%
%	a = Brandn(sz)
%	Same usage as randn, half the speed but better the distribution
%
%	[a,b] = Brandn(sz)
%	Return two independent standard-normal-distributed matrices
%
%	See also randn
    if nargout==0
		histogram(sqrt(-2*log(rand(varargin{:},"gpuArray"))).*sinpi(2*rand(varargin{:},"gpuArray")))
        return
    end
    if isgpuarray(varargin{1})
        if nargout==1
            varargout={sqrt(-2*log(rand(varargin{:},"gpuArray"))).*sinpi(2*rand(varargin{:},"gpuArray"))};
        else
            x1=sqrt(-2*log(rand(varargin{:},"gpuArray")));
            x2=2*rand(varargin{:},"gpuArray");
            varargout={x1.*sinpi(x2),x1.*cospi(x2)};
        end
    else
        if nargout==1
            varargout={sqrt(-2*log(rand(varargin{:}))).*sinpi(2*rand(varargin{:}))};
        else
            x1=sqrt(-2*log(rand(varargin{:})));
            x2=2*rand(varargin{:});
            varargout={x1.*sinpi(x2),x1.*cospi(x2)};
        end
    end
end