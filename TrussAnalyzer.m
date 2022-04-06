% Coding Lead: Tristen Liu
% Group members: Samuel Haley, Hector Castro

%Import setup file
filename = "TrussPractice.mat";              %Replace with file name
load(filename);

%Setup
[joints, members] = size(C);
Sfull = [Sx; Sy];
   
MemberCoeff = zeros(2*joints, members); 
Pcrit = zeros(members); %The critical buckling force of each member
Wfail = zeros(members); %The maximum load given Pcrit of each member

totalLen = 0; %sum of all the lengths for use in total cost calculation

%Calculate length, Pcrit, and MemberCoeff index for each member
for M = 1:members
   %Finding joints for each member
   i = 0;
   index = [0 0];           %index of the XY coordinate
   for J = 1:joints
       if(C(J,M) == 1)      %if they are connected in connection matrix
           i = i+1;
           index(i) = J;
       end
       if(i == 2)           %only 2 joints per member
           break;
       end
   end
   fprintf('%d\t%d\n',index(1),index(2));
   
   %Calculating distance between two joints
   Xdif = X(index(2)) - X(index(1));
   Ydif = Y(index(2)) - Y(index(1));
   dist = sqrt(Xdif*Xdif + Ydif*Ydif);  %find distance between two joints
   
   totalLen = totalLen + dist;
   
   %Calculating Pcrit for each member, using Power fit from lab data
   Pcrit(M) = 3908.184 * dist^(-2.211);
   
   %Calculating Wfail using Pcrit
   Wfail(M) = -Pcrit(M) / dist;
   
   %Filling out the coefficient matrix
   %x-component coefficients
   MemberCoeff(index(1),M) = (X(index(2)) - X(index(1))) / dist;
   MemberCoeff(index(2),M) = (X(index(1)) - X(index(2))) / dist;
   %y-component coefficients
   MemberCoeff(joints+index(1),M) = (Y(index(2)) - Y(index(1))) / dist;
   MemberCoeff(joints+index(2),M) = (Y(index(1)) - Y(index(2))) / dist;
   
end

%A * T = L -> T = A^-1 * L
%A is the compound matrix of MemberCoeff and Sfull
%T is a vector that contians all of the unknown forces
%L is the Load vector that is loaded in the setup file

A = [MemberCoeff Sfull];
T = A \ L;

printTruss(T,L,joints,members,totalLen);
















