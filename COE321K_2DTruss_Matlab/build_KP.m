% TO-DO List:
% Multiply K_ele by EA/L

function [K,P] = build_KP(nnode,node_coor,nelem,elemdata,nforce,forcedata);
% Summary of this function goes here
%   nnode - number of nodes
%   node_coord - contains x and y coordingates for ith node
%   nelem - number of elemets
%   elemdata - node1, node2, Area(in^2), YM(psi)
%   force_BCs - number of boundary conditions
%   forcedata - node, dof, value(lbs)

% Initialize the Global Stiffness Matrix K & Support Force Vector P
K = zeros(2*nnode,2*nnode);
P = zeros(2*nnode,1);

for e = 1:nelem
    node1 = elemdata(e,1);
    node2 = elemdata(e,2);

    node1_x = node_coor(node1,1);
    node1_y = node_coor(node1,2);

    node2_x = node_coor(node2,1);
    node2_y = node_coor(node2,2);

    rise = node2_y - node1_y;
    run = node2_x - node1_x;
    hypotenuse = sqrt(rise^2 + run^2);

    c = run/hypotenuse;
    s = rise/hypotenuse;

    % Initialize & oCnstruct the Elemental Stiffness Matrix
    K_ele = zeros(4,4);
    K_ele = [c^2, c*s, -(c^2), -(c*s); 
        c*s, s^2, -(c*s), -(s^2); 
        -(c^2), -(c*s), c^2, c*s;
        -(c*s), -(s^2), c*s, s^2];
    
    % Multiply K_ele by (EA/L) 
    % L = hypotenuse
    E = elemdata(e,4);
    A = elemdata(e,3);

    % Note: Convert L to in.
    K_ele = ((E*A)/(hypotenuse*12)) * K_ele;

    % Construct the Connectivity Vectory
    gdof1 = 2*(elemdata(e,1)-1)+1;
    gdof2 = 2*(elemdata(e,1)-1)+2;
    gdof3 = 2*(elemdata(e,2)-1)+1;
    gdof4 = 2*(elemdata(e,2)-1)+2;

    gcon = [gdof1, gdof2, gdof3, gdof4];

    % Assemble the Global Matrix
    for row = 1:4
        for col = 1:4
            K(gcon(row), gcon(col)) = K(gcon(row), gcon(col)) + K_ele(row,col);
        end
    end
end

% Apply the force boundary conditions
for num = 1:nforce
    % If dof = 1, x-direction
    % If dof = 2, x-direction
    c = forcedata(num,1); % global node number
    node_dof = forcedata(num,2); % DOF at that node
    
    P((c-1)*2 + node_dof) = forcedata(num,3); 

end

end
