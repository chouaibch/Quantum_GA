%function GAQ  = GAQ(Task,Workers,PairDist)
clear;
clc;
Workers = [0.66 1.00 0.53 0.00 0.13 0.00 ;
           0.00 0.00 0.66 0.73 0.66 0.13 ;
           0.00 0.33 0.53 0.00 0.80 0.93 ;
           0.40 0.30 0.70 0.80 0.50 0.80 ;
    ];
Task = [1.8 1.4 1.66 3.0 3];
PairDist = [0.00 1.00 0.66 0.66 0.85 0.66 ;
            1.00 0.00 0.66 0.85 0.66 0.85 ;
            0.66 0.66 0.00 0.40 0.66 0.40 ;
            0.66 0.85 0.40 0.00 0.40 0.00 ;
            0.85 0.66 0.66 0.40 0.00 0.40 ;
            0.66 0.85 0.40 0.00 0.40 0.00 ; 
    ];

pop=(rand(10,6));
[n,m] = size(pop);
newSolus = zeros(n,m);
%crossover
i=1;
while(i<n)
    crossover1 = pop(i,:);
    crossover2 = pop(i+1,:);
    cross1 = crossover1(1:round(length(crossover1)/2));
    cross2 = crossover1(round(length(crossover1)/2)+1:length(crossover1));
    cross3 = crossover2(1:round(length(crossover2)/2));
    cross4 = crossover2(round(length(crossover2)/2)+1:length(crossover2));
    newSolus(i,:) = [cross1 cross4];
    newSolus(i+1,:) = [cross3 cross2];
    i=i+2;
end

%mutation
mutindx=0;
for(j=1:n)
    while(mutindx == 0)
    mutindx = round(6*rand);
    end
    newSolus(j,mutindx)= 1 - newSolus(n,mutindx);
end
all = cat(1,pop,newSolus);
[n,m] = size(all);
classic_Sols = zeros(n,m);
for (i=1:n)
    for(j=1:m)
        if(all(i,j)>rand)
            classic_Sols(i,j)=1;
        end
    end
end

classic_Sols
BestSet = [];
QuanSol= [];
SelectSetS=[];
BestDia = 2;
for (i=1:n)
    BinarySet = classic_Sols(i,:);
    SelectedSet = find(BinarySet==1);
    %cheking cost
    SetCost = 0;
    for j=1:length(SelectedSet)
       SetCost = SetCost + Workers(end,SelectedSet(j));
    end
    if( SetCost>Task(end-1))
        disp(SetCost);
        display('Cost constraint is not satisfied.');
    else
        display('Cost constraint is satisfied.');
        display('Checking skills constraints :');
        %checking skills constraints
        SetSkill = 0;
           for d=1 : size(Workers,1)-1
            for w=1:length(SelectedSet)
                SetSkill = SetSkill + Workers(d,SelectedSet(w));
            end;
             fprintf('domain : %d \n',d);
                display(SetSkill);
            if(SetSkill<Task(d))
                SetSkill = 0;
                display('Skill constraint is not satisfied');
                display('--------------------------------------------');
                break;
            else
                display('Skill constraint is satisfied');
                if(d == size(Workers,1)-1)
                    SetDia = GetDia(SelectedSet,PairDist);
                    diary on;
                    disp('******Set found******');
                    disp(SelectedSet);
                    QuanSol(end+1) = i;
                    fprintf('Cost : %f \n',SetCost);              
                    fprintf('Dia : %f \n',SetDia);
                    disp('********************');
                    diary off;
                    if(BestDia>SetDia)
                        diary on;
                        disp('Best Set updated');
                        diary off;
                        BestDia = SetDia;
                        BestSet = SelectedSet;
                    end
                end
            end
           end
    end
end


