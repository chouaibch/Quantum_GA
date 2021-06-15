function skill = CalcSkills(SelectedSet,Workers,d)
  SetSkill = 0;
    for w=1:length(SelectedSet)
        SetSkill = SetSkill + Workers(d,SelectedSet(w));
    end; 
        skill =SetSkill;
end