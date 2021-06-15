%For a given set of workers the function returns the diamater (max distance between a pair)
function Dia = GetDia(Set,PairDist)
    Dia=0;
    if( isempty(Set))
        return;
    else
        if(length(Set)==1)
            Dia=0;
            return;
        end
    end;
        Combos=nchoosek(Set,2);
        for i=1:size(Combos,1)

            if(Dia<PairDist(Combos(i,1),Combos(i,2)))
                Dia=PairDist(Combos(i,1),Combos(i,2));
            end;

        
    end;

end