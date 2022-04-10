% Coding Lead: Tristen Liu
% Group members: Samuel Haley, Hector Castro

%Import data file
%filename = "TrussPractice.mat";        %Replace with file name
filename = "TrussDesign4_Hector_Sam_Tristen.mat";
load(filename);

%Setup
[joints, members] = size(C);
Sfull = [Sx; Sy];
   
MemberCoeff = zeros(2*joints, members); 
Pcrit = zeros(members,1);       %The critical buckling force of each member
Wfail = zeros(members,1);       %The maximum load given Pcrit of each member
WfailLow = zeros(members,1);    %The range of failure given Pcrit range
WfailHigh = zeros(members,1);

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
   
   %Calculating distance between two joints
   Xdif = X(index(2)) - X(index(1));
   Ydif = Y(index(2)) - Y(index(1));
   dist = sqrt(Xdif*Xdif + Ydif*Ydif);  %find distance between two joints
   
   totalLen = totalLen + dist;
   
   %Calculating Pcrit for each member, using Power fit from lab data
   Pcrit(M) = 3908.184 * dist^(-2.211);
   
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
%T is a vector that contains all of the unknown forces
%L is the Load vector that is loaded in the setup file

A = [MemberCoeff Sfull];
T = inv(A) * L;

%Finding max load using equations 7 and 10
Tm = T(1:members);
Rm = Tm/sum(L);

for M = 1:members
    if (Tm(M) > 0)
        %Given the strength of members in tension is Inf.
        Wfail(M) = Inf;   
        WfailLow(M) = Inf;   
        WfailHigh(M) = Inf; 
    else
        %Error range 4.116 given in Buckling Fit Plot
        Wfail(M) = -Pcrit(M) / Rm(M);
        WfailLow(M) = -(Pcrit(M) - 4.116) / Rm(M);
        WfailHigh(M) = -(Pcrit(M) + 4.116) / Rm(M);
    end
end

%Finding Max Theoretical Loads
%The lowest value in Wfail is the maximum load the truss can withstand
%The indexes of the max load should be the same
[maxLoad, indx] = min(abs(Wfail));
maxLoadL = min(abs(WfailLow));
maxLoadH = min(abs(WfailHigh));

maxLoadAll = [maxLoad, maxLoadL, maxLoadH, indx];

%Call printing function
printTruss(T,L,joints,members,totalLen,maxLoadAll);
















