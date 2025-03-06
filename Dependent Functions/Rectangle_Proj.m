function [intersectionPoint, ID_Tri] = Rectangle_Proj(x,y,height, A,B,C,D, Area,ray_directions, dt_O_Norm,dt_Ray_Norm, range)
    epsilon = 1e-6;  % Small number to handle precision
    % Translate the rays based on the scanner's position
    numRays = size(ray_directions, 1);
    intersectionPoint = inf(numRays, 3);
    ID_Tri = zeros(numRays, 1);  % Initializing ID_Tri array
    numTri=length(A);

    % Extract all point intersections
    s=-dt_O_Norm./dt_Ray_Norm;
    s(abs(s)>range)=inf;
    s(s<0)=inf;
    px=x+ray_directions(:,1).*s;
    py=y+ray_directions(:,2).*s;
    pz=height+ray_directions(:,3).*s;
    pCos=zeros(numRays,numTri);

    for i=1:numTri
        p=[px(:,i),py(:,i),pz(:,i)];
        pa=p-A(i,:);
        pb=p-B(i,:);
        pc=p-C(i,:);
        pd=p-D(i,:);
        aa=(vecnorm(cross(pa,pb),2,2)+vecnorm(cross(pa,pd),2,2)+vecnorm(cross(pb,pc),2,2)+vecnorm(cross(pc,pd),2,2))/2-Area(i);
        pCos(abs(aa)<epsilon,i)=1;
    end
    s(pCos==0)=inf;
    [v,r]=min(s,[],2);
    ff=find(v<inf);
    ID_Tri(ff)=r(ff);
    ind = sub2ind([numRays,numTri],ff,r(ff));
    intersectionPoint(v<inf,:)=[px(ind),py(ind),pz(ind)];
end