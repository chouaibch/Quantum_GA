%function of crossover
function Cross = Crossover(pop)
[n,m] = size(pop);
newSolus = zeros(n,m);
i=1;
while(i<n)
    crossover1 = pop(i,:);
    crossover2 = pop(i+1,:);
    %random number to get position of crosserver
    position = round(m*rand);
    cross1 = crossover1(1:position);
    cross2 = crossover1(position+1:length(crossover1));
    cross3 = crossover2(1:position);
    cross4 = crossover2(position+1:length(crossover2));
    newSolus(i,:) = [cross1 cross4];
    newSolus(i+1,:) = [cross3 cross2];
    i=i+2;
end
Cross = newSolus;
end