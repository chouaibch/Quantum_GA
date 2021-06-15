function cost = CalcCost(SelectedSet,Workers)
 SetCost = 0;
    for j=1:length(SelectedSet)
       SetCost = SetCost + Workers(end,SelectedSet(j));
    end
    cost = SetCost;
end