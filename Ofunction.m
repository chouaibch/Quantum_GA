%objectif function
function f = Ofunction(SelectedSet,PairDist,Workers)
SetDia = GetDia(SelectedSet,PairDist);
SetCost = CalcCost(SelectedSet,Workers);
SetSkillS = CalcSkills_Of(SelectedSet,Workers);
f = (SetDia + SetCost) - SetSkillS; 
end