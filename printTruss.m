%Printing the details of the Truss

function printTruss(T,L,joints,members,totalLen)
    disp('\% EK301, Section A2: Tristen L., Samuel H., Hector C., 4/5/2022.');
    fprintf('Load: %.2foz \n', sum(L));
    
    fprintf('Member forces in oz:\n');
    for i = 1:size(T)
        %first (member) indexes are member forces
        if (i <= members)
            if (T(i) > 0)
                fprintf('m%d: \t%6.3f (T)\n',i,T(i));
            elseif (T(i) < 0)
                fprintf('m%d: \t%6.3f (C)\n',i,abs(T(i)));
            else
                fprintf('m%d: \t%6.3f (Z)\n',i,abs(T(i)));
            end
        else %last three indexes are reaction forces
            if (i == members+1)
                fprintf('Reaction forces in oz:\n');
                fprintf('Sx1: %4.2f\n',T(i));
            elseif (i == members+2)
                fprintf('Sy1: %4.2f\n',T(i));
            elseif (i == members+3)
                fprintf('Sy2: %4.2f\n',T(i));
            end
        end
    end
    
    cost = 10*joints + 1*totalLen;
    fprintf('Cost of truss: $%.2f\n',cost);
    fprintf('Theoretical max load/cost ratio in oz/$: %.4f\n',sum(L)/cost);
end






