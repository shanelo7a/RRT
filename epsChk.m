function [chk] = epsChk(x,y,X,Y,eps)
    
    dist=euclidean(x,y,X,Y);
    if dist <= eps
        chk = 1;
    else
        chk = 0;
    end
    
end