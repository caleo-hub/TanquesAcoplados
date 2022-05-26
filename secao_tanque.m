function [A1,A2] = secao_tanque(h1,h2)

    if h1 < 7.5
        d1 = 0;
    elseif h1 < 19.5
        d1 = (h1 - 7.5)/2;
    elseif h1 < 29.5
        d1 = 6;
    elseif h1 < 41.5
        d1 = (41.5 - h1)/2;
    else
        d1 = 0;
    end
    A1 = 9*(8+d1);
    
    if h2 < 7.5
        d2 = 6; 
    elseif h2 < 19.5
        d2 = (19.5 - h2)/2;
    elseif h2 < 29.5
        d2 = 0;
    elseif h2 < 41.5
        d2=(h2 - 29.5)/2;
    else
        d2 = 6;
    end
    A2 = 9*(14+d2);

    
end