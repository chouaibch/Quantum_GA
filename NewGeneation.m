function Ng = NewGeneation(all,QSol,Others,BestS,PopSize)
C=0.8;
[n,m] = size(all);
newSolus = [];
if(length(QSol)>PopSize)
    max = PopSize;
else
    max =length(QSol);
end
for (c=1:max)
    newSolus(c,:)=all(QSol(c),:);
end
r = PopSize - length(QSol);
x=1;
o=length(QSol);
for (b=o+1:PopSize)
     newSolus(b,:)=all(Others(x),:);
     x=x+1;
end
newSolus;
BestMatrix = repmat(BestS,PopSize,1);
newSolus_ = (newSolus+C*BestMatrix)/(C+1);
Ng = newSolus_;
end