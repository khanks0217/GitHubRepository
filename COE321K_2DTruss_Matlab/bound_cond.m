function [K,P] = bound_cond(K,P,ndisp,dispdata,M);
    % K - global stiffness matrix
    % P - force vector
    % ndisp - Number of displacement Boundary Conds.
    % dispdata - node, dof, value (in)
        % X Dir : (dof = 1)
        % Y Dir : (dof = 2)
    % M - set number of penalty method for infinitely stiff spring

    for bc = 1:ndisp
        node = dispdata(bc, 1);
        dof = dispdata(bc, 2);
    
        % Construct the Connectivity Vectory
        gdof_x = 2*(node-1)+ dof;

        % Add penalty contributions to the force vector
        P(gdof_x) = P(gdof_x)+ M*dispdata(bc,3);

        % Add penalty contributions to the stiffness matrix
        K(gdof_x,gdof_x) = K(gdof_x,gdof_x) + M;

    end
end