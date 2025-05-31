classdef (InferiorClasses={?sym}) d
    properties(GetAccess=private,SetAccess=private,Hidden=true)
        value
        vars
    end
    methods
        function res=d(x,vars)
            arguments
                x=[]
                vars=symvar(x)
            end
            if class(x)=="sym"
                for i=vars
                    res.value=[res.value diff(x,i)];
                end
                res.vars=vars;
            elseif class(x)=="d"
                for i=1:length(x.value)
                    for j=vars
                        if isempty(intersect(x.vars(:,i),j))
                            flag=false;
                            for k=1:length(res.value)
                                if isequal(sort([j;x.vars(:,i)]),res.vars(:,k))
                                    res.value(k)=res.value(k)+diff(x.value(i),j)*(-1)^nxs([j;x.vars(:,i)]);
                                    flag=true;
                                    break
                                end
                            end
                            if ~flag
                                res.vars=[res.vars sort([j;x.vars(:,i)])];
                                res.value=[res.value diff(x.value(i),j)*(-1)^nxs([j;x.vars(:,i)])];
                            end
                        end
                    end
                end
            end
        end
        function vars=symvar(self)
            vars=union(symvar(self.value),self.vars);
        end
        function pretty(self)
            pretty(eval(self));
        end
        function disp(self)
            disp(eval(self));
        end
        function eval=eval(self)
            eval=sym(0);
            for i=1:length(self.value)
                eval=eval+self.value(i)*prod(sym("d"+string(self.vars(:,i))));
            end
            eval=simplify(eval);
        end
        function sym=sym(self)
            sym=eval(self);
        end
        function res=times(self,other)
            if class(other)~="d"
                res=simplify(eval(self).*other);
            elseif class(self)~="d"
                res=simplify(self.*eval(other));
            else
                res=simplify(eval(self).*eval(other));
            end
        end
        function res=mtimes(self,other)
            res=d;
            if class(other)~="d"
                res.value=self.value*other;
                res.vars=self.vars;
            elseif class(self)~="d"
                res.value=other.value*self;
                res.vars=other.vars;
            else
                for i=1:length(self.value)
                    for j=1:length(other.value)
                        if isempty(intersect(self.vars(:,i),other.vars(:,j)))
                            flag=false;
                            for k=1:length(res.value)
                                if isequal(sort([self.vars(:,i);other.vars(:,j)]),res.vars(:,k))
                                    res.value(k)=res.value(k)+self.value(i)*other.value(j)*(-1)^nxs([self.vars(:,i);other.vars(:,j)]);
                                    flag=true;
                                    break
                                end
                            end
                            if ~flag
                                res.vars=[res.vars sort([self.vars(:,i);other.vars(:,j)])];
                                res.value=[res.value self.value(i)*other.value(j)*(-1)^nxs([self.vars(:,i);other.vars(:,j)])];
                            end
                        end
                    end
                end
            end
        end
        function res=mpower(self,n)
            arguments
                self (1,1) d
                n (1,1) double {isPositiveIntegerValuedNumeric}
            end
            res=d;
            if n==1
                res.value=self.value;
                res.vars=self.vars;
            end
        end
        function res=power(self,n)
            arguments
                self (1,1) d
                n (1,1)
            end
            res=eval(self).^n;
        end
        function res=uplus(self)
            res=self;
        end
        function res=uminus(self)
            res=d;
            res.value=-self.value;
            res.vars=self.vars;
        end
        function res=plus(self,other)
            res=d;
            if class(self)~="d"
                if ~isempty(other.value)
                    error('XZHError: 你这个不同阶的微分形式加个鬼！')
                else
                    res.value=self+other.value;
                end
            elseif class(other)~="d"
                if ~isempty(self.value)
                    error('XZHError: 你这个不同阶的微分形式加个鬼！')
                else
                    res.value=self.value+other;
                end
            else
                if length(self.vars(:,1))~=length(other.vars(:,1))
                    error('XZHError: 你这个不同阶的微分形式加个鬼！')
                end
                res=d;
                res.value=self.value;
                res.vars=self.vars;
                for i=1:length(other.value)
                    flag=false;
                    for j=1:length(res.value)
                        if isequal(other.vars(:,i),res.vars(:,j))
                            res.value(j)=res.value(j)+other.value(i);
                            flag=true;
                            break
                        end
                    end
                    if ~flag
                        res.vars=[res.vars other.vars(:,i)];
                        res.value=[res.value other.value(i)];
                    end
                end
            end
        end
        function res=minus(self,other)
            res=self+-other;
        end
    end
end
function nxs=nxs(a)
    arguments
        a (1,:)
    end
    [~,I]=sort(a);
    nxs=sum(sum(triu(I-I')<0));
end