function displayinternal(self,name,mode)
	arguments(Input)
		self dnm
		name(1,:)char
		mode(1,1){mustBeMember(mode,["disp","display"])}="display"
	end
	showheader=mode=="display";
	header="  "+matlab.internal.display.dimensionString(self,true);
	switch ndims(self)
		case 0
			header="  "+formattedclassstr(self)+" scalar";
		case 1
			header=header+" "+formattedclassstr(self)+" vector";
		case 2
			header=header+" "+formattedclassstr(self)+" matrix";
		otherwise
			header=header+" "+formattedclassstr(self)+" tensor";
	end
	if isempty(self)
		header=header+" with properties:";
	end
	try
		try
			value_str=arrayfun(@get_cropped_str,self.value,"uniformoutput",false);
		catch
			value_str=cell(paddata(size(self),2,fillvalue=1));
			for ind=1:numel(self)
				value_str{ind}=get_cropped_str(self.value(ind));
			end
		end
		if ndims(self)&&~isempty(self)||showheader
			fprintf("\n")
		end
		if ndims(self)<=2||isempty(self)
			if ~isempty(name)
				disp(name+" =")
				fprintf("\n")
			end
		end
		if showheader
			disp(header)
			fprintf("\n")
		end
		if isempty(self)
			s=split(string(evalc("builtin(""disp"",self)")),newline);
			fprintf(s(end-2)+"\n")
			fprintf("\n")
		else
			switch ndims(self)
				case 0
					if mode=="display"
						if ischar(self)
							disp(regexprep(repr(string(self.value),"display"),"""(.*)""","'$1'"))
						elseif isstring(self)
							disp(repr(self.value,"display"));
						else
							disp(repr(self.value,"disp"));
						end
					else
						disp(self.value)
					end
				case 1
					index_str1=arrayfun(@get_cropped_str,(1:size(self,1))',"uniformoutput",false);
					ret=[{"","","","";self.dimnames(1),"","","";"","","",""};index_str1,repmat({""},size(self,1),2),value_str];
					catndisp(ret)
					fprintf("\n")
				case 2
					index_str1=arrayfun(@get_cropped_str,(1:size(self,1))',"uniformoutput",false);
					index_str2=arrayfun(@get_cropped_str,1:size(self,2),"uniformoutput",false);
					ret=[{"",self.dimnames(2),"";self.dimnames(1),"","";"","",""},[index_str2;repmat({""},2,size(self,2))];index_str1,repmat({""},size(self,1),2),value_str];
					catndisp(ret)
					fprintf("\n")
				otherwise
					out=outclass;
					star=starclass;
					pages=combinations(star{arrayfun(@(x)1:size(self,x),3:ndims(self),"uniformoutput",false),2}{:});
					pages=pages{:,:}';
					index_str1=arrayfun(@(x)get_cropped_str(x),(1:size(self,1))',"uniformoutput",false);
					index_str2=arrayfun(@(x)get_cropped_str(x),1:size(self,2),"uniformoutput",false);
					for i=pages
						disp(name+"("+join(self.dimnames+"="+["':'","':'",string(i')],",")+").squeeze(3"+ternary(ndims(self)==3,"",":"+string(ndims(self)))+") =")
						fprintf("\n")
						ret=[{"",self.dimnames(2),"";self.dimnames(1),"","";"","",""},[index_str2;repmat({""},2,size(self,2))];index_str1,repmat({""},size(self,1),2),value_str(:,:,star{i})];
						catndisp(ret)
						fprintf("\n")
						if ~isequal(i,pages(:,end))
							fprintf("\n")
						end
					end
			end
		end
	catch
		if ~isempty(name)
			fprintf("\n")
			disp(name+" =")
			fprintf("\n")
		end
		ret=evalc("builtin(""disp"",self)");
		if ~isempty(ret)&&ret(end)==newline
			ret=ret(1:end-1);
		end
		ret=string(ret);
		ret=replace(ret,regexpPattern(".*?dnm.*? with properties:"),header+" with properties:");
		disp(ret)
	end
end
function ret=get_cropped_str(x)
	arguments(Input)
		x(1,1)
	end
	arguments(Output)
		ret(:,1)string
	end
	if ischar(x)
		ret=regexprep(repr(string(x),"display"),"""(.*)""","'$1'").split(newline);
	elseif isstring(x)
		ret=repr(x,"display").split(newline);
	else
		ret=repr(x,"disp").split(newline);
	end
	ret=setstrboundsize(ret,getstrboundsize(ret));
	isemptystr=contains(ret,regexpPattern("^ *?$"));
	ret=ret(find(~isemptystr,1,"first"):find(~isemptystr,1,"last"));
	while all(startsWith(ret," "))
		ret=arrayfun(@(x)extractAfter(x,1),ret);
	end
	while all(endsWith(ret," "))
		ret=arrayfun(@(x)extractBefore(x,strlength(x)-1),ret);
	end
	if numel(ret)>double(string(fileread("maxdisp.txt")))
		ret="### TOO LONG ###";
	end
end
function ret=getstrboundsize(x,i)
	arguments(Input)
		x(:,1)
		i(1,:){mustBeInteger,mustBePositive}=1:2
	end
	arguments(Output)
		ret(1,:)double{mustBeInteger,mustBeNonnegative}
	end
	ret(1)=numel(x);
	ret(2)=max(arrayfun(@(x)strlength(regexprep(x,"<.*?>(.*?)</.*?>","$1")),x));
	ret=ret(i);
end
function x=setstrboundsize(x,i,side)
	arguments(Input)
		x(:,1)
		i(1,2){mustBeInteger,mustBeNonnegative}
		side(1,1)string{mustBeMember(side,["left","right","both"])}="right"
	end
	arguments(Output)
		x(:,1)
	end
	x=paddata(x,i(1),"dimension",1,"fillvalue","");
	x=arrayfun(@(x)pad(x,i(2)+strlength(x)-strlength(regexprep(x,"<.*?>(.*?)</.*?>","$1")),side),x);
end
function catndisp(ret)
	tmp=max(cellfun(@(x)getstrboundsize(x,1),ret(1:3,:)),[],"all");
	ret(1:3,:)=cellfun(@(x)setstrboundsize(x,[tmp,0]),ret(1:3,:),"uniformoutput",false);
	tmp=max(cellfun(@(x)getstrboundsize(x,1),ret(4:end,:)),[],"all");
	ret(4:end,:)=cellfun(@(x)setstrboundsize(x,[tmp,0]),ret(4:end,:),"uniformoutput",false);
	tmp=max(cellfun(@(x)getstrboundsize(x,2),ret(:,1:3)),[],"all")+4;
	ret(:,1:3)=cellfun(@(x)setstrboundsize(x,[0,tmp],"left"),ret(:,1:3),"uniformoutput",false);
	tmp=max(cellfun(@(x)getstrboundsize(x,2),ret(:,4:end)),[],"all")+4;
	ret(:,4:end)=cellfun(@(x)setstrboundsize(x,[0,tmp],"left"),ret(:,4:end),"uniformoutput",false);
	disp(join(join(zsc.cell2mat(ret),"",2),newline,1))
end
function ret=formattedclassstr(x)
	classes=string(class(x));
	while string(class(x))~=string(underlyingType(x))
		x=gather(x);
		classes=[classes,string(class(x))];
	end
	if matlab.internal.display.isHot
		ret=join("<a href=""matlab:helpPopup('"+classes+"')"" style=""font-weight:bold"">"+classes+"</a>"," ");
	else
		ret=join(classes," ");
	end
end