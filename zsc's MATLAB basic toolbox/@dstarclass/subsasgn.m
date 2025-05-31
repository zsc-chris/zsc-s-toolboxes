function self=subsasgn(self,S,B)
	arguments(Input)
		self dstarclass
		S(:,1)struct
	end
	arguments(Input,Repeating)
		B
	end
	arguments(Output)
		self
	end
	if S(1).type=="."
		self=builtin("subsasgn",self,S,B{:});
	else
		if S(1).type=="()"
			zsc.assert(numel(B)>=1,message("MATLAB:minrhs"))
			zsc.assert(numel(B)<=1,message("MATLAB:maxrhs"))
			B=B{:};
			zsc.assert(iscell(B),message("MATLAB:badargs"))
			zsc.assert(size(B,1)==2,"MATLAB:subsassigndimmismatch","Size of the first dimension of the cell input must be 2.")
		end
		B=reshape(B,2,[]);
		B(1,:)=cellfun(@string,B(1,:),"uniformoutput",false);
		try
			mapping=evalin("caller",S(1).subs{1});
		catch
			mapping=struct;
		end
		if isa(mapping,"table")
			if size(mapping,2)==2&&(isstring(mapping{:,1})||iscellstr(mapping{:,1}))
				mode=1;
			else
				mode=2;
			end
		elseif isa(mapping,"dictionary")
			mode=3;
		elseif isa(mapping,"struct")
			mode=4;
		else
			error(message("MATLAB:badargs"))
		end
		for i=1:size(B,2)
			switch mode
				case 1
					if i==1
						VariableNames=mapping.Properties.VariableNames;
						mappingx=string(mapping{:,1});
						mappingy=mapping{:,2};
						out=outclass;
					end
					ind=ifinline(zsc.ismember(B{1,i},mappingx),@()out{2,2,@zsc.ismember,B{1,i},mappingx},@()numel(mappingx)+1);
					mappingx(ind,:)=B{1,i};
					if isempty(mappingy)
						mappingy=zsc.subsasgn([],[substruct("()",{ind,':'}),S(2:end)],B{2,i});
					else
						mappingy=zsc.subsasgn(mappingy,[substruct("()",{ind,':'}),S(2:end)],B{2,i});
					end
					if i==size(B,2)
						mapping=table(mappingx,mappingy,'VariableNames',VariableNames);
					end
				case 2
					try
						mapping.(B{1,i})=zsc.subsasgn(subsref(mapping,substruct(".",B{1,i})),S(2:end),B{2,i});
					catch
						mapping.(B{1,i})=zsc.subsasgn([],S(2:end),B{2,i});
					end
				case 3
					if i==1
						try
							mapping=mapping.entries;
						catch
							mapping=table([],[]);
						end
						mappingx=string(mapping{:,1});
						mappingy=mapping{:,2};
						out=outclass;
					end
					ind=ternary(zsc.ismember(B{1,i},mappingx),out{2,2,@zsc.ismember,B{1,i},mappingx},numel(mappingx)+1);
					mappingx(ind,:)=B{1,i};
					if isempty(mappingy)
						mappingy=zsc.subsasgn([],[substruct("()",{ind,':'}),S(2:end)],B{2,i});
					else
						mappingy=zsc.subsasgn(mappingy,[substruct("()",{ind,':'}),S(2:end)],B{2,i});
					end
					if i==size(B,2)
						mapping=dictionary(mappingx,mappingy);
					end
				case 4
					mapping=subsasgn(mapping,[substruct(".",B{1,i}),S(2:end)],B{2,i});
			end
		end
		if ~contains(S(1).subs{1},[".","(",")","{","}"])
			assignin("caller",S(1).subs{1},mapping)
		else
			varname=join([string(evalin("caller","who"));"a"],"");
			assignin("caller",varname,mapping)
			try
				evalin("caller",S(1).subs{1}+"="+varname+";");
			catch ME
			end
			evalin("caller","clear "+varname)
			if exist("ME","var")
				rethrow(ME)
			end
		end
	end
end