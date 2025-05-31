function ret=pcolor3(varargin,options)
%pcolor3	3D data visualization
%	pcolor3(<X,Y,Z>,D) plots the field D in 3D with transluscent pcolor in
%	each plane. The size of D can be (:,:,:) (scalar field) or (:,:,:,3)
%	(vector field). The size of X,Y,Z must be (1,:), the ":" being the size
%	of D in that respective dimension.
%
%	See also pcolor, volumeViewer

%	Copyright 2024 Chris H. Zhao
	arguments(Repeating)
		varargin(:,:,:,:)double
	end
	arguments
		options.facealpha(1,:)double=-1
	end
	switch numel(varargin)
		case 1
			D=varargin{:};
			X=1:size(D,1);
			Y=1:size(D,2);
			Z=1:size(D,3);
		case 4
			[X,Y,Z,D]=varargin{:};
		otherwise
			error('Input number incorrect. Input must be D or X,Y,Z,D.')
	end
	if ~ishold
		clf
	end
	hld=ishold;
	hold on
	assert(ismember(numel(options.facealpha),[1,3]))
	switch options.facealpha
		case -1
			options.facealpha=(1-.3^inv(mean(cellfun(@numel,{X,Y,Z}))))*[1 1 1];
		case -2
			options.facealpha=cellfun(@(x)1-.3^inv(numel(x)),{X,Y,Z});
		otherwise
			if numel(options.facealpha)==1
				options.facealpha=options.facealpha*[1 1 1];
			end
	end
	if length(size(D))==3
		for i=1:length(X)
			[tmpy,tmpz]=meshgrid(Y,Z);
			ret(1,i)=surf(X(i)*ones(size(D,[3,2])),tmpy,tmpz,'cdata',reshape(D(i,:,:),size(D,[2,3]))','facealpha',options.facealpha(1),'edgecolor','none');
		end
		for i=1:length(Y)
			[tmpx,tmpz]=meshgrid(X,Z);
			ret(2,i)=surf(tmpx,Y(i)*ones(size(D,[3,1])),tmpz,'cdata',reshape(D(:,i,:),size(D,[1,3]))','facealpha',options.facealpha(2),'edgecolor','none');
		end
		for i=1:length(Z)
			[tmpx,tmpy]=meshgrid(X,Y);
			ret(3,i)=surf(tmpx,tmpy,Z(i)*ones(size(D,[2,1])),'cdata',reshape(D(:,:,i),size(D,[1,2]))','facealpha',options.facealpha(3),'edgecolor','none');
		end
	else
		for i=1:length(X)
			[tmpy,tmpz]=meshgrid(Y,Z);
			ret(1,i)=surf(X(i)*ones(size(D,[3,2])),tmpy,tmpz,'cdata',reshape(D(i,:,:,1),size(D,[2,3]))','facealpha',options.facealpha(1),'edgecolor','none');
		end
		for i=1:length(Y)
			[tmpx,tmpz]=meshgrid(X,Z);
			ret(2,i)=surf(tmpx,Y(i)*ones(size(D,[3,1])),tmpz,'cdata',reshape(D(:,i,:,2),size(D,[1,3]))','facealpha',options.facealpha(2),'edgecolor','none');
		end
		for i=1:length(Z)
			[tmpx,tmpy]=meshgrid(X,Y);
			ret(3,i)=surf(tmpx,tmpy,Z(i)*ones(size(D,[2,1])),'cdata',reshape(D(:,:,i,3),size(D,[1,2]))','facealpha',options.facealpha(3),'edgecolor','none');
		end
	end
	view(3)
	hold(matlab.lang.OnOffSwitchState(hld))
	if nargout==0
		clear ret
	end
end