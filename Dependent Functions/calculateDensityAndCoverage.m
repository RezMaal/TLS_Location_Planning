function [density,coverageRatio,Coverage_Points,Ang_A,Ang_B,Coef] = calculateDensityAndCoverage(Area,Attribute,intersectionPoint, ID_Tri,sf,x,y,height)
    % Initialize dictionaries to store densities and coverage ratios
    coverageRatio = zeros(1,sf);
    density = zeros(1,sf);
    
    % Iterate over each triangle
    ii=unique(ID_Tri);
    ii=setdiff(ii,0);
    Coverage_Points=cell(1,sf);
    Ang_A=zeros(sf,2);
    Ang_B=zeros(sf,2);
    Coef=zeros(sf,1);
    for i = 1:length(ii)
        intersectionPoints = intersectionPoint(ID_Tri==ii(i),:);
        % Calc
        Rot=Rodrigues(Attribute(ii(i),1:3),[0,0,1]);        
        p=intersectionPoints*Rot;
        d=eig(cov(p(:,1:2))); dd=max(d)/sum(d);
        if dd<0.999
            % Density
            numPoints = size(intersectionPoints, 1);
            density(ii(i)) = numPoints / Area(ii(i)); % points per square meter
            % Coverage
            [k,hullArea] = convhull(p(:,1:2),'Simplify',true); 
            coverageRatio(ii(i)) = hullArea / Area(ii(i));
            Coverage_Points{1,ii(i)}=p(k,1:2);
            Rot=Rodrigues(Attribute(ii(i),1:3),[1,0,0]);        
            Cc=(intersectionPoints(k,:)-[x,y,height])*Rot;
            NT=vecnorm(Cc,2,2);
            Alf=asin(Cc(:,3)./NT);
            Bet=atan2(Cc(:,2),Cc(:,1))+pi;
            Ang_A(ii(i),:)=[min(Alf),max(Alf)];
            Ang_B(ii(i),:)=[min(Bet),max(Bet)];
            Coef(ii(i),1)=Area(ii(i))/prod(max(Cc(:,2:3))-min(Cc(:,2:3)));
        end
    end
end