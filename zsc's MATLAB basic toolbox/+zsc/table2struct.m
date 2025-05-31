function S=table2struct(T,options)
%zsc.table2struct	Improved version of MATLAB table2struct.
%	S=table2struct(T,ToScalar=false) is the exact inverse of struct2table.
	arguments(Input)
		T table
		options.ToScalar(1,1)logical=false
	end
	arguments(Output)
		S struct
	end
	if options.ToScalar
		S=struct;
		for i=1:size(T,2)
			S.(T.Properties.VariableNames{i})=T{:,i};
		end
	else
		S=repmat(struct,size(T,1),1);
		for i=1:size(T,2)
			tmp=num2cell(T{:,i},2);
			[S.(T.Properties.VariableNames{i})]=tmp{:};
		end
	end
end