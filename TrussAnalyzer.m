% Coding Lead: Tristen Liu
% Group members: Samuel Haley, Hector Castro

%Import setup file


%Setup
[joints, members] = size(C);
Sfull = [Sx, Sy];
   
MemberCoeff = zeros(2*joints, members); 
Pcrit = zeros(members, 1); %The critical buckling force of each member
Wfail = zeros(members, 1); %The maximum load given Pcrit of each member

totalLen = 0; %sum of all the lengths for use in total cost calculation

%Calculate length, Pcrit, and MemberCoeff index for each member
for M = 1:members
   %Finding joints for each member
   i = 0;
   index = [0 0]; %index of the XY coordinate
   for J = 1:joints
       if(C(V,M) == 1) %if they are connected in connection matrix
           i = i+1;
           index(i) = J;
       end
       if(i == 2) %only 2 joints per member
           break;
       end
   end
    
   
end
    















