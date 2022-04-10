# EK301 Truss Code
This repository contains code written by students to calculate the Tension and Compression forces in simple trusses. 

The code works under the following assumptions: 
- The structure is well modeled as a pin-jointed two dimensional truss. 
- The strength of the truss members in tension is practically infinite. 
- The strength of the joints is practically infinite. 
- The dominant failure mechanism is buckling of the individual members. 
- The material used is a length of acrylic sheet, with a buckling force power fit F = 3908.184*L^-2.211 and error 4.116 

To test your own matrix, you can modify the code in Test_Setup.m 
1. Change the connection (C) matrix to fit your own joints and members 
2. Change the X and Y coordinates to the coordinates of your own joints 
3. Modify the Sx and Sy matrices only if your reaction forces are not: 
       - A pin at joint 1 
       - A roller at joint 8 
4. Change the Load vector to your own load and joint 
5. If you change the name of the saved .mat file, change 'filename' in the TrussAnalyzer accordingly 
6. Run the setup script, then run TrussAnalyzer.m 

- The TrussAnalyzer code will calculate the tension/compression forces in each member, the failure load of each member if the member is in compression as well as the range of possible failures. 
- It will then call the print function to print the load, forces in each member, reaction forces at the supports, the cost of the truss, the max theoretical load & its range, and the max load/cost ratio. 
- Note that the print function is designed to work for only 3 reaction forces
