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

%Number of iturations
NumItr=10;

%Random initialization of our population
initial=(rand(5,6));   
[c,l] = size(initial);

%Random initialization of our best binary
%that satisfy constraint of skill and cost
Bskiil= false;
Bcost= false;
while( Bskiil== false || Bcost== false)
for(a=1:l)
    BestSetBinary(a)=round(1*rand);
end
    BestSet = find(BestSetBinary);
    Bcost=ChekCost(BestSet,Workers,Task);
    Bskiil=ChekSkills(BestSet,Workers,Task);
end
%Value of objective function for best birary
BestOf = Ofunction(BestSet,PairDist,Workers); 
disp(['The initial best binary is: [' num2str(BestSetBinary(:).') ']']) ;
disp(['Our best solution is: [' num2str(BestSet(:).') ']']) ;
fprintf('Objectif Funtion = %f .\n',BestOf);
disp('QGA are Started ' );
for (itr=1:NumItr)
fprintf('//////////////////////////////////// Genaration = %d \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.\n',itr);
%newSolus = zeros(n,m);
pop = initial;
newSolus = pop;
%crossover
if(rand>rand)
newSolus  = Crossover(pop);
end
%mutation
if(rand>rand)
newSolus = Mutation(newSolus);
end
%all solutions ( initial population of individuals 
%and our individus after crossover and mutation)
all = cat(1,pop,newSolus);
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
    BinarySet = classic_Sols(i,:);
    SelectedSet = find(BinarySet);
    %For each SelectedSet check Skill and Cost constraints
    %Checking if cost constraint is satisfied
    %SetCost = CalcCost(SelectedSet,Workers);
    
    if(ChekCost(SelectedSet,Workers,Task)==false)
     %   disp(SetCost);
      %  display('Cost constraint is not satisfied.');
        SetIndx(end+1)= i;
        SetOfindx(end+1)=  Ofunction(SelectedSet,PairDist,Workers);
    else
       % display('Cost constraint is satisfied.');
       % display('Checking skills constraints :');
        %checking skills constraints
        SetSkill = 0;
          % for d=1 : size(Workers,1)-1
           %    SetSkill = CalcSkills(SelectedSet,Workers,d)
            % fprintf('domain : %d \n',d);
              %  display(SetSkill);
            if(ChekSkills(SelectedSet,Workers,Task)==false)
               % SetSkill = 0;
             %   display('Skill constraint is not satisfied');
              %  display('--------------------------------------------');
             %   SetOf = Ofunction(SelectedSet,PairDist,Workers);
                SetIndx(end+1)= i;
                SetOfindx(end+1)=  Ofunction(SelectedSet,PairDist,Workers);
                
            else
               % display('Skill constraint is satisfied');
               % if(d == size(Workers,1)-1)
                   % SetDia = GetDia(SelectedSet,PairDist);
                    SetOf = Ofunction(SelectedSet,PairDist,Workers);
                    %diary on;
                    disp('------- | Solution found | -------');
                  %  disp(SelectedSet);
                  disp(['The Solution is: [' num2str(SelectedSet(:).') ']']) ;
                  fprintf('Cost = %f .\n',CalcCost(SelectedSet,Workers));
                  for d=1 : size(Workers,1)-1
                    SetSkill = CalcSkills(SelectedSet,Workers,d);
                     fprintf('Skills in domain : %d  = %f \n',d,SetSkill);
                   %  display(SetSkill);
                  end
     
                  fprintf('Objectif Funtion = %f .\n',SetOf);
                    QuanSol(end+1) = i;
                    Of_values(end+1) = SetOf;
                  %  fprintf('Cost : %f \n',SetCost);              
                   % fprintf('Dia : %f \n',SetOf);
                    disp('------------------------------------');
                    %diary off;
                    if(BestOf>SetOf)
                       % diary on;
                        disp('Best Set updated');
                        disp(['The best binary is: [' num2str(BinarySet(:).') ']']) ;
                        disp(['Our best solution is: [' num2str(SelectedSet(:).') ']']) ;
                        fprintf('Objectif Funtion = %f .\n',SetOf);
                       % diary off;
                        BestOf = SetOf;
                        BestSetBinary = BinarySet;
                        BestSet = SelectedSet;
                    end
                end
          %  end
          %end
    end
end
        %array with indices of solution they are not satisfies
        %the constraints of skill and cost
        %sorted by objective function value
        [SetOfindx,idx] = sort(SetOfindx,'ascend');
        SetIndx = SetIndx(idx);
        
        
        %array with indices of solution they are satisfies
        %the constraints of skill and cost
        %sorted by objective function value
        [Of_values,idxof] = sort(Of_values,'ascend');
        QuanSol = QuanSol(idxof);
        fprintf('//////////////////////////////////// End genaration = %d \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\.\n',itr);
        disp('New generation');
        %New generation
        initial = NewGeneation(all,QuanSol,SetIndx,BestSetBinary,c);
       
end

disp(['Our best solution is: [' num2str(BestSet(:).') ']']) ;
fprintf('Objectif Funtion = %f .\n',BestOf);
        

