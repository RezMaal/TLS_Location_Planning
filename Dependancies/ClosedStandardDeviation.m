function [Std_D,aa,bb,p0] = ClosedStandardDeviation(x,y,height,Attribute, aa,bb,s0,sa,Coef)

    p0=Attribute*[x,y,height,1]';
    epsi=0.02;
    Std_D=zeros(1,length(p0));
    ii=intersect(find(abs(aa(:,2)-aa(:,1))>epsi),find(abs(bb(:,2)-bb(:,1))>epsi));
    aa=aa(ii,:);
    bb=bb(ii,:);
    p0=p0(ii);
    Coef=Coef(ii);
    St_D=abs(real(s0^2+p0.^2.*sa^2./(aa(:,2)-aa(:,1)).*(tan(aa(:,2))-tan(aa(:,1)))+p0.^2.*sa^2./(bb(:,2)-bb(:,1)).*(tan(bb(:,2))-tan(bb(:,1)))-2.*p0.^2.*sa^2)).*Coef;
    Std_D(1,ii(~isnan(St_D)))=sqrt(St_D(~isnan(St_D))');
end