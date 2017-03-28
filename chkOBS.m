function [OBSTCL] = chkOBS(x,y,obsAry)

for i=1:length(obsAry)
    chk=euclidean(x,y,obsAry(i,1),obsAry(i,2));
    if chk <= obsAry(i,3)
        OBSTCL = 0;
    else
        OBSTCL = 1;
    end
end

end
    