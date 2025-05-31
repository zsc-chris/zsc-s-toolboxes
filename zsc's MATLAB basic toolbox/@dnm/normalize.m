function [ret,C,S]=normalize(self,dims,varargin)
	arguments(Input)
		self dnm
		dims(1,:){mustBeA(dims,["logical","double","string","char","cell"])}=1:ndims(self)
	end
	arguments(Input,Repeating)
		varargin
	end
	arguments(Output)
		ret dnm
		C dnm
		S dnm
	end
	if isempty(varargin)
		varargin={"zscore"};
	end
	varargin(1:2:end)=cellfun(@string,varargin(1:2:end),"uniformoutput",false);
	zsc.assert(all(ismember([varargin{1:2:end}],["zscore","norm","scale","range","center","medianiqr"])),message("MATLAB:normalize:InvalidMethod"))
	zsc.assert(numel(varargin)<=2||numel(varargin)<=4&&isequal(sort([varargin{[1,3]}]),["center","scale"]),message("MATLAB:normalize:InvalidDoubleMethod"))
	zsc.assert(varargin{1}~="medianiqr"||isscalar(varargin),message("MATLAB:normalize:IncorrectNumInputsArray"))
	out=outclass;
	switch 4*(varargin{1}=="center")+2*(ismember(varargin{1},["center","scale"])&&~isstring(varargin{2}))+(numel(varargin)>=3&&ismember(varargin{3},["center","scale"])&&~isstring(varargin{4}))
		case {0,4}
			[ret,C,S]=applyalong(self,@normalize,dims,mode="flatten",keepdims=[true,false],unflatten=[true,false],additionalinput=varargin);
		case 1
			C=varargin{4};
			[ret,S]=fevalalong(@(self,methodtype2,dim)out{3,[1,3],@normalize,self,dim,varargin{1:3},methodtype2,varargin{5:end}},dims,self,varargin{4},mode="flatten",keepdims=[true,false],unflatten=[true,false],broadcastsizedims="");
		case 2
			S=varargin{2};
			[ret,C]=fevalalong(@(self,methodtype,dim)normalize(self,dim,varargin{1},methodtype,varargin{3:end}),dims,self,varargin{2},mode="flatten",keepdims=[true,false],unflatten=[true,false],broadcastsizedims="");
		case 3
			C=varargin{4};
			S=varargin{2};
			ret=fevalalong(@(self,methodtype,methodtype2,dim)normalize(self,dim,varargin{1},methodtype,varargin{3},methodtype2,varargin{5:end}),dims,self,varargin{[2,4]},mode="flatten",keepdims=[true,false],unflatten=[true,false],broadcastsizedims="");
		case 5
			S=varargin{4};
			[ret,C]=fevalalong(@(self,methodtype2,dim)normalize(self,dim,varargin{1:3},methodtype2,varargin{5:end}),dims,self,varargin{4},mode="flatten",keepdims=[true,false],unflatten=[true,false],broadcastsizedims="");
		case 6
			C=varargin{2};
			[ret,S]=fevalalong(@(self,methodtype,dim)out{3,[1,3],@normalize,self,dim,varargin{1},methodtype,varargin{3:end}},dims,self,varargin{2},mode="flatten",keepdims=[true,false],unflatten=[true,false],broadcastsizedims="");
		case 7
			C=varargin{2};
			S=varargin{4};
			ret=fevalalong(@(self,methodtype,methodtype2,dim)normalize(self,dim,varargin{1},methodtype,varargin{3},methodtype2,varargin{5:end}),dims,self,varargin{[2,4]},mode="flatten",keepdims=[true,false],unflatten=[true,false],broadcastsizedims="");
	end
end