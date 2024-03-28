function [Ps,F,Sigma] = forces(nnode,node_coor,nelem,elemdata,ndisp,dispdata,U,M)
    % Ps - Reaction Forces
    % F - Internal Forces
    % nnode - number of nodes
    % node_coor - contains x and y coordingates for ith node
    % nelem - number of elemets
    % elemdata - node1, node2, Area(in^2), YM(psi)
    % ndisp - Number of displacement Boundary Conds.
    % dispdata - dispdata - node, dof, value (in)
        % X Dir : (dof = 1)
        % Y Dir : (dof = 2)
    % U - global displacement vector
    % M - set number of penalty method for infinitely stiff spring

    % Calculate the Support Reactions (Ps)
    Ps = zeros(nnode, 2);
    u0 = 0;
    for n = 1:ndisp
        node = dispdata(n,1);
        dof = dispdata(n,2);
        gdof= 2*(node-1)+ dof;

        Ps(node,dof) = (-M) * (U(gdof)-u0);
    end

    Sigma = zeros(nelem);

    % Calculate the internal forces
    for ne = 1:nelem
        node1 = elemdata(ne,1);
        node2 = elemdata(ne,2);
        % u_bar : nodal displ for the given element
        % u_bar = (u2 - u1)i + (v2 - v1)j

        gdof_x1 = 2*(node1-1)+ 1;
        gdof_y1 = 2*(node1-1)+ 2;
        gdof_x2 = 2*(node2-1)+ 1;
        gdof_y2 = 2*(node2-1)+ 2;

        u1= U(gdof_x1);
        v1 = U(gdof_y1);
        u2 = U(gdof_x2);
        v2 = U(gdof_y2);

        u_bar = [u2 - u1, v2  - v1];

        % e_bar : found from nodal coord
        % e_bar = (1/L)(x2 - x1)i + (1/L)(y2 - y1)j
    
        node1_x = node_coor(node1,1);
        node1_y = node_coor(node1,2);
    
        node2_x = node_coor(node2,1);
        node2_y = node_coor(node2,2);

        rise = node2_y - node1_y;
        run = node2_x - node1_x;
        hypotenuse = sqrt(rise^2 + run^2);
        e_bar = (1/(12 * hypotenuse))*[run,rise];


        % Calculate Strains
        Epsilon = (1/(hypotenuse))*dot(u_bar,e_bar);
        Sigma(ne) = elemdata(ne,4) * Epsilon;

        F(ne) = Sigma(ne) * elemdata(ne,3);


    end

end