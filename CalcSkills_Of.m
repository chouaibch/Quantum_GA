function skill = CalcSkills_Of(SelectedSet,Workers)
  SetSkill = 0;
  
    for d=1 : size(Workers,1)-1
        for w=1:length(SelectedSet)
            SetSkill = SetSkill + Workers(d,SelectedSet(w));
        end
    end
   skill =  SetSkill/d;
end