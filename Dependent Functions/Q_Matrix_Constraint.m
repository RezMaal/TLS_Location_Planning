function Q = Q_Matrix_Constraint(Sc,Attribute,Ang_Thresh,T_m,T_M)

    atc=acos(abs(Attribute(:,1:3)*Attribute(:,1:3)'));
    At=zeros(size(atc,1),size(atc,2));
    At(atc>=Ang_Thresh)=1;
    sz=size(Sc,1);
    Q=zeros(sz,sz);
    
    for i=1:sz-1
        for j=i+1:sz
            ii=find(sum(Sc([i;j],:))==2);
            if ~isempty(ii)
                G=graph(At(ii,ii));
                [~,binsizes] = conncomp(G);
                if max(binsizes)<T_m || max(binsizes)>T_M
                   Q(i,j)=1;
                end
            end
        end
    end
    Q=Q+Q';
end