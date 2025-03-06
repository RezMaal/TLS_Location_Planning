%% Coverage Guarantee using Linear Programming
% Linear term of objective function
St=ones(1,sf);
for i=1:sf
    as=sum(coverage(:,i)>0);
    St(i)=(1+as/sz)^da;
end
Cc=Linear_C(Std_D,coverage,density,St); % combining LOA, LOC and LOD
Nc=ones(sz,1)./sz; % adding # of scan stations into the linear term

% Hard constraints for surface coverage
Sc=zeros(sz,sf);
Sc(coverage>Mc)=1;
Ns=find(sum(Sc)>0);
Ac=-Sc';
bc=-ones(sf,1);

intcon = 1:sz; % number of decision variables

% Finding Optimal Solution through Linear Integer Programming
[x_L,fval_L] = intlinprog(Nc+Cc,intcon,Ac(Ns,:),bc(Ns),[],[],zeros(sz,1),ones(sz,1));

%% Quadratic Registrability Formulation (You need Gurobi)
% Note: It is also possible to use the QUBO function after relaxation of
% the linear constraints.

% Creating the Connectivity Graph
Q = Q_Matrix_Constraint(Sc(:,Ns),Att_BIM(Ns,:),Ang_Thresh,km,kM);
Qc= ~Q-eye(sz);

% Finding Optimal Solution through Quadratic Integer Programming
result=Gurobi_QBP(Q,-diag(Nc),Ac(Ns,:),bc(Ns));