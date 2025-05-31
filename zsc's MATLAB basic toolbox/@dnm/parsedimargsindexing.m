function [self,subs]=parsedimargsindexing(self,subs,mode)
	arguments(Input)
		self dnm
		subs(1,:)cell
		mode(1,1)string{mustBeMember(mode,["subsref","subsasgn"])}="subsref"
	end
	arguments(Output)
		self dnm
		subs(3,:)cell
	end
	if isempty(subs)
		subs=cell(3,0);
		return
	end
	star=starclass;
	dstar=dstarclass;
	if isscalar(subs)&&(isstruct(subs{1})||isa(subs{1},"dictionary")||isa(subs{1},"table"))
		subs=dstar(subs{1});
		if isempty(subs)
			subs=cell(3,0);
			return
		end
		subs(2,:)=cellfun(@(x)ifinline(iscell(x),@()x,@(){x}),subs(2,:),"uniformoutput",false);
	elseif iscell(subs{1})||isnumeric(subs{1})||islogical(subs{1})||isequal(subs{1},':')
		subs={catdims(self.dimnames);subs};
	else
		subs=reshape(subs,2,[]);
		subs(2,:)=cellfun(@(x)ifinline(iscell(x),@()x,@(){x}),subs(2,:),"uniformoutput",false);
	end
	subs(2,:)=arrayfun(@(x){x},subs(2,:));
	% subs=subs(:,cellfun(@(x)isempty(x)||~ismissing(x),subs(1,:)));
	subs=table2cell(removevars(groupsummary(cell2table(subs',"variablenames",["dims","subs"]),"dims",@(x){cat(2,x{:})},"subs"),"GroupCount"))';
	subs=subs(:,~cellfun(@isempty,subs(2,:)));
	for i=1:size(subs,2)
		dims=splitdim(subs{1,i},numel(subs{2,i}));
		sz=arrayfun(@(dim)end_(self,ifinline(ismember(dim,self.dimnames),@()dim,@()splitdim(dim))),dims);
		for j=1:numel(subs{2,i})
			if isequal(subs{2,i}{j},':')
				subs{2,i}{j}=1:sz(j);
			end
			if islogical(subs{2,i}{j})
				subs{2,i}{j}=find(subs{2,i}{j});
			end
			if ~isdnm(subs{2,i}{j})
				subs{2,i}{j}=dnm(subs{2,i}{j},dims(j));
			elseif ~ismember(dims(j),subs{2,i}{j}.dimnames)
				subs{2,i}{j}.dimnames=[subs{2,i}{j}.dimnames,dims(j)];
			end
			zsc.assert(all(ismember(subs{2,i}{j}.dimnames,dims)),"DNM:indexing:dimensionnotingroup","Dimensions of DNMs must be present in their group. To create new dimension, use a new group with the dimension, or use more subscripts in a group than the group size (not recommended).")
		end
		if mode=="subsref"
			try
				zsc.assert(all(arrayfun(@(x,y)paddata(max(gather(x{1}),[],"all"),1)<=y,subs{2,i},sz)),message("MATLAB:badsubscript","Index out of bound."))
			catch ME
				rethrowAsCaller(ME)
			end
		else
			try
				zsc.assert(ismember(dims(end),self.dimnames)||~contains(dims(end),"×")||paddata(max(gather(subs{2,i}{end}),[],"all"),1)<=sz(end),"MATLAB:indexed_matrix_cannot_be_resized","Attempt to grow array along ambiguous dimension.")
			catch ME
				rethrowAsCaller(ME)
			end
			if ismember(dims(end),self.dimnames)||~contains(dims(end),"×")
				self=paddata(self,cellfun(@(x)paddata(gather(max(x)),1),subs{2,i}),dimension=dims);
			else
				self=paddata(self,cellfun(@(x)paddata(gather(max(x)),1),subs{2,i}(1:end-1)),dimension=dims(1:end-1));
			end
		end
		sz=arrayfun(@(dim)end_(self,ifinline(ismember(dim,self.dimnames),@()dim,@()splitdim(dim))),dims);
		[subs{2,i}{:}]=feval(@deal,subs{2,i}{:});
		subs{2,i}=sub2ind(paddata(sz,2,"fillvalue",1),star{subs{2,i},2}{:}.value);
		subs{3,i}=size(subs{2,i},1:numel(dims));
		subs{2,i}=flatten(subs{2,i});
	end
end