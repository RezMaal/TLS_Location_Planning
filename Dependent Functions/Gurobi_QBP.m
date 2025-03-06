function result=Gurobi_QBP(Q,f,A,B)
    
    %% Initialization
    model.modelname = 'QIP';
    model.modelsense = 'min';  % for minimization, use 'max' for maximization
    
    n = size(Q,1);  % Assuming Q is an n x n matrix
    model.lb = zeros(n, 1);  % Lower bounds of variables (0)
    model.ub = ones(n, 1);   % Upper bounds of variables (1)
    model.vtype = repmat('I', n, 1);  % Variable types, 'I' for integer
    model.varnames = arrayfun(@(i) sprintf('x%d', i), 1:n, 'UniformOutput', false);
    
    model.Q = sparse(Q-f);  % Quadratic part of the objective
    model.obj = zeros(n,1);  % Linear part of the objective, set to zero if not needed
    
    %% Linear Constraint
    model.A = sparse(A);
    model.rhs = B;  % Right-hand side of the equation
    model.sense = repmat('<', length(B), 1);  % Equality constraints
  
    %% Solution
    result = gurobi(model);
end