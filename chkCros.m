function [cross] = chkCros(x,y,xEnd,yEnd,obs)

for i=1:length(obs)
    line=[x,y,xEnd,yEnd];
    circle=obs(i,:);
    [p]=intersectLineCircle(line, circle);
    if sum(p)>0
        cross = 0;
    else 
        cross = 1;
    end
end