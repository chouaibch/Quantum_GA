%function of mutation
function Mut = Mutation(newSolusC)
[n,m] = size(newSolusC);
mutindx=0;
for(j=1:n)
    %random number to get position of mutation
    mutindx = round(m*rand);
    while(mutindx == 0)
    mutindx = round(6*rand);
    end
        p=newSolusC(j,mutindx);
        newSolusC(j,mutindx) = (1 - p);  
end

Mut = newSolusC;
end