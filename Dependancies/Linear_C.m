function C=Linear_C(ang,coverage,density,St)
    [sz,sc]=size(coverage);
    Sc=zeros(sz,sc);
    Sc(coverage>0)=1;
    Sc=Sc./St;
    Sc=sum(Sc,2);
    % density=density./St;
    density_Score=sum(density,2);
    % coverage=coverage./St;
    coverage_Score=sum(coverage,2);
    % coverage_Score=ones(sz,1);
    ang_Score=max(ang,[],2);
    C=ang_Score./coverage_Score./density_Score./Sc;
    C=C./sum(C);
end