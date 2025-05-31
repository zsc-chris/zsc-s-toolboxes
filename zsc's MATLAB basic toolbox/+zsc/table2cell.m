function C=table2cell(T)
%zsc.table2cell	Improved version of MATLAB table2cell.
%	C=table2cell(T) is the exact inverse of cell2table.
	arguments(Input)
		T table
	end
	arguments(Output)
		C cell
	end
	C=cell(size(T));
	for i=1:size(T,2)
		C(:,i)=num2cell(T{:,i},2);
	end
end