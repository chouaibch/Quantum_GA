function chek = ChekSkills(array,Workers,Task)
SetSkill = 0;
for d=1 : size(Workers,1)-1
   SetSkill = CalcSkills(array,Workers,d);
if(SetSkill<Task(d))
    SetSkill = 0;
    chek = false;
    return;
else
    if(d == size(Workers,1)-1)
        chek = true;
        return;
    end
end
end
end