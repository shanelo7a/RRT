function [OBSTCL] = chkOBS(x,y,obsAry)

for i=1:length(obsAry)
    chk=euclidean(x,y,obsAry(i,1),obsAry(i,2));
    if chk <= obsAry(i,3)
        OBSTCL = 1;
    else
        OBSTCL = 0;
    end
end

end
    
