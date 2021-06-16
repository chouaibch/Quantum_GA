function chek = ChekCost(array,Workers,Task)
 SetCost = CalcCost(array,Workers);
    if( SetCost>Task(end-1))
        chek=false;
    else
        chek=true;
    end
end