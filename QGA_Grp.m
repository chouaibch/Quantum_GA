%function GAQ  = GAQ(Task,Workers,PairDist)
clear;
clc;
BestSetBinary = [];
BestSet = [];
SetIndx= [];
SetOfindx = [];
QuanSol= [];
Of_values= [];
SelectSetS=[];
BestDia = 2;
BestOf = 10; 
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
NumItr=10;
initial=(rand(30,6));

[c,l] = size(initial);
for (itr=1:NumItr)
%newSolus = zeros(n,m);
pop = initial
%crossover
newSolusC  = Crossover(pop)
%mutation
newSolusM = Mutation(newSolusC)
%all solutions ( initial population of individuals 
%and our individus after crossover and mutation)
all = cat(1,pop,newSolusM);
[n,m] = size(all);
%generate classic population from quantums
classic_Sols = zeros(n,m);
for (i=1:n)
    for(j=1:m)
        if(all(i,j)>rand)
            classic_Sols(i,j)=1;
        end
    end
end

for (i=1:n)
    BinarySet = classic_Sols(i,:)
    SelectedSet = find(BinarySet)
    %For each SelectedSet check Skill and Cost constraints
    %Checking if cost constraint is satisfied
    SetCost = CalcCost(SelectedSet,Workers);
    if( SetCost>Task(end-1))
        disp(SetCost);
        display('Cost constraint is not satisfied.');
        SetIndx(end+1)= i;
                SetOfindx(end+1)=  Ofunction(SelectedSet,PairDist,Workers);
    else
        display('Cost constraint is satisfied.');
        display('Checking skills constraints :');
        %checking skills constraints
        SetSkill = 0;
           for d=1 : size(Workers,1)-1
               SetSkill = CalcSkills(SelectedSet,Workers,d)
             fprintf('domain : %d \n',d);
                display(SetSkill);
            if(SetSkill<Task(d))
                SetSkill = 0;
                display('Skill constraint is not satisfied');
                display('--------------------------------------------');
             %   SetOf = Ofunction(SelectedSet,PairDist,Workers);
                SetIndx(end+1)= i;
                SetOfindx(end+1)=  Ofunction(SelectedSet,PairDist,Workers);
                break;
            else
                display('Skill constraint is satisfied');
                if(d == size(Workers,1)-1)
                   % SetDia = GetDia(SelectedSet,PairDist);
                    SetOf = Ofunction(SelectedSet,PairDist,Workers);
                    %diary on;
                    disp('******Set found******');
                    disp(SelectedSet);
                    QuanSol(end+1) = i;
                    Of_values(end+1) = SetOf;
                    fprintf('Cost : %f \n',SetCost);              
                    fprintf('Dia : %f \n',SetOf);
                    disp('********************');
                    %diary off;
                    if(BestOf>SetOf)
                       % diary on;
                        disp('Best Set updated');
                       % diary off;
                        BestOf = SetOf;
                        BestSetBinary = BinarySet;
                        BestSet = SelectedSet;
                    end
                end
            end
           end
    end
end
        [SetOfindx,idx] = sort(SetOfindx,'ascend');
        SetIndx = SetIndx(idx);
        
        [Of_values,idxof] = sort(Of_values,'ascend');
        QuanSol = QuanSol(idxof);
        if( isempty(BestSetBinary))
             disp('AUCUUUUUUUUUUN SOLUTION');
            BestSetBinary=classic_Sols(SetIndx(1),:);
        end
        initial = NewGeneation(all,QuanSol,SetIndx,BestSetBinary,c);
        disp('NEW GENERATIONNNNNNNNNNNNNNNNNNNNNNN');
end

