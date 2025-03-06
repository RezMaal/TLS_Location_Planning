%% Tunable Parameters

% Scanner Grid Resolution 
% Note: Lower Values Will Considerably Decrease Speed
dx=2; % grid size in x-axis
dy=2; % grid size in y-axis

% Scanner Properties
s0=0.003;   %range standard deviation
sa=0.000125; % angular standard deviation
alpha_max = 180; % Maximum alpha value
beta_ang = 60; % Maximum beta value
range = 30; % Range for the scanner
min_Dist=0.5; % minimum range of scanner
epsilon=10^-3;

% Angular Resolution of Rays
% Note: Lowering the Values Will Considerably Decrease Speed
alpha_res = 0.25; % Resolution for alpha
beta_res = 0.25; % Resolution for beta

% Note: The Default Values Takes ~930seconds on Macbook Pro M2

% Problem Thresholds
Ang_Thresh=pi/6; % registrability angular threshold
km=3; % minimum # of planes with over Ang_Thresh planar surfaces
kM=7; % maximum # of planes with over Ang_Thresh planar surfaces
Mc=0.3; % minimum acceptable coverage of surface
da=2; % power function controlling the importance of coverage

% Reading Mesh File of BIM Elements
OBJ = ["Wall" "Column" "Floor"];
maxNum=[3,20,2];
L=sum(maxNum);
stz=Reading_STL_Elements(maxNum,OBJ);
Bounds_BIM=[];
Att_BIM=[];
Area_BIM=[];
for i=1:L
    [Att,Bb,Ar]=readSTLPolyGraph(stz(i));
    Att_BIM=[Att_BIM;Att];
    Bounds_BIM=[Bounds_BIM;Bb];
    Area_BIM=[Area_BIM;Ar];
end

% Initial Scan Position Candidates
xg=0.5:dx:32;
yg=-5.5:dy:14;
[X,Y]=meshgrid(xg,yg);
X=reshape(X,[],1);
Y=reshape(Y,[],1);
sz=size(X,1);
Z=-1.5*ones(sz,1);
Z(Y>=0)=1.8;
xyz=[X,Y,Z];
Rho=[xyz,ones(sz,1)]*Att_BIM';
Rem=find(abs(Rho)<=min_Dist);
[r,c]=ind2sub([sz,L],Rem);
Pr=xyz(r,:)-Rho(Rem).*Att_BIM(c,1:3);
cr=-sign(Rho(Rem)).*Att_BIM(c,1:3);
a_Pr=atan2(cr(:,2),cr(:,1));
b_Pr=asin(cr(:,3));
iR=ones(sz,1);
for i=1:length(c)
    pB=Bounds_BIM{c(i),1}-Pr(i,:);
    a_B=atan2(pB(:,2),pB(:,1));
    b_B=asin(pB(:,3)./vecnorm(pB,2,2));
    pgon=polyshape(a_B,b_B);
    bb=[a_Pr-0.1,b_Pr-0.1;a_Pr+0.1,b_Pr-0.1;a_Pr+0.1,b_Pr+0.1;a_Pr-0.1,b_Pr+0.1];
    [in,on] = isinterior(pgon,bb);
    if sum(in)+sum(on)>0
       iR(r(i))=0;
    end
end
xyz=xyz(iR==1,:);
sz=sum(iR);


% Problem Initializations
sf=size(Att_BIM,1);
A=zeros(sf,3);
B=zeros(sf,3);
C=zeros(sf,3);
D=zeros(sf,3);
for i=1:sf
    p=Bounds_BIM{i,1};
    A(i,:)=p(1,:); B(i,:)=p(2,:); C(i,:)=p(3,:); D(i,:)=p(4,:);
end
ray_directions = TLSscanner(alpha_max, beta_ang, alpha_res, beta_res);
dt_Ray_Norm=ray_directions*Att_BIM(:,1:3)';
dt_O_Norm=[xyz,ones(sz,1)]*Att_BIM'; % Angle between origin and normal

clearvars -except dt_O_Norm dt_Ray_Norm range ray_directions A B C D xyz Area_BIM Att_BIM Bounds_BIM sf sz s0 sa da Mc Ang_Thresh km kM

density=zeros(sz,sf);
coverage=zeros(sz,sf);
ang=zeros(sz,1);
Std_D=coverage;
coverage_P=cell(sz,sf);

tic;
for i = 1:sz    
    
    % Finding Intersecting Points between Scanner Position i and All Surfaces 
    [intersection_points, ID_Tri] = Rectangle_Proj(xyz(i,1), xyz(i,2), xyz(i,3), A, B, C, D,Area_BIM, ray_directions, dt_O_Norm(i,:), dt_Ray_Norm, range); 

    % Calculation of Density, Coverage and Incidence Angle
    [density(i,:), coverage(i,:), coverage_P(i,:),Ang_A,Ang_B,Coef] = calculateDensityAndCoverage(Area_BIM,Att_BIM,intersection_points, ID_Tri,sf,xyz(i,1), xyz(i,2), xyz(i,3));
    
    % Calculation of Level of Accuracy
    Std_D(i,:) = ClosedStandardDeviation(xyz(i,1), xyz(i,2), xyz(i,3),Att_BIM, Ang_A,Ang_B,s0,sa,ones(sf,1));
    
    % Display every 10 Iterations
    if rem(i,10)==0
        disp(['Iteration ----> ', num2str(i)])
    end

end
toc 