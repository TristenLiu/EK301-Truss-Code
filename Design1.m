%Connection Matrix setup
%The rows j represent joints, and columns m represent the members
%For example, if (1,1) = 1, then joint 1 is connected to member 1, and 0
%otherwise.
C = [ [1 0 0 1 0 0 0 0 0 0 0 0 0];
      [1 1 0 0 1 1 0 0 0 0 0 0 0];
      [0 1 1 0 0 0 1 1 1 0 0 0 0];
      [0 0 1 0 0 0 0 0 0 1 0 0 0];
      [0 0 0 1 1 0 0 0 0 0 1 0 0];
      [0 0 0 0 0 1 1 0 0 0 1 1 0];
      [0 0 0 0 0 0 0 1 0 0 0 1 1];
      [0 0 0 0 0 0 0 0 1 1 0 0 1] ];

[joints, members] = size(C);

%X Y Coordinates for the location of each joint
X = [0 18.13 26.79 32 9.18 18.14 26.79 32];
Y = [0 0 0 0 9 9 9.83 7.34];

%Construction matrix for the support forces
%Column 1 represents the horizontal reaction force at pin 1
%A value of 1 in Sx(1,1) means at pin 1 there is a horizonal reaction F
%A value of 1 in Sy(1,2) means at pin 1 there is a vertical reaction F
Sx1 = zeros(joints, 1); 
Sy1 = zeros(joints, 1); 
Sy2 = zeros(joints, 1);

Sx = [Sx1 Sy1 Sy2]; Sy = [Sx1 Sy1 Sy2];
Sx(1,1) = 1; Sy(1,2) = 1; Sy(8,3) = 1;

%Defining the Load vector L
%The first j columns represent the Horizontal Load force at the j'th pin
%The last j columns represent the Vertial Load force at the j'th pin
L = zeros(2*joints, 1);

L(joints+3,1) = 32;         %There is a 32N vertical load at pin 3

%Testing validity of truss
if (members ~= 2*joints-3)
    fprintf('Error! Please check your contruction matrix for mistakes\n');
else
    save('TrussDesign4_Hector_Sam_Tristen.mat','C','Sx','Sy','X','Y','L');
end











