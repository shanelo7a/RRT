clear all;
close all;

x=0; y=0;                           %map origin
X=100; Y=100;                       %map max

xStart=75; yStart=85;               %start V
xGoal=100; yGoal=0;rGoal=20;        %goal V
EPS=5;                              %epslon
k=500000;                           %iteration limit
currIdx=1;                          %iteration
prevIdx=1;
res=100;
biasing = 0.2;                       % goal biasing threshold
OBS = csvread('obstacles.txt');

tree.V(1).x = xStart;
tree.V(1).y = yStart;
tree.V(1).xPrev = xStart;
tree.V(1).yPrev = yStart;
tree.V(1).flag=1;


for i=1:k 
    disp(['Iteration ' num2str(i)]);
    % Generate a random point with probability < threshold
    disp('Generated Point');
    if rand() < biasing
        disp('Biasing Goal');
        x = xGoal;
        y = yGoal;
    else
        disp('Random Point');
        [x,y]=randPnt(res,xGoal,yGoal);
    end
    
    % Check if point is epsilon worthy
    if epsChk(x,y,tree.V(prevIdx).x,tree.V(prevIdx).y,EPS) == 1
        disp('*******Epsilon Valid*********');
        currIdx = currIdx + 1;
        % Add point to tree, but keep flag = 0
        tree.V(currIdx).x = x;
        tree.V(currIdx).y = y;
        tree.V(currIdx).flag = 0;
        % For new point, update the x_prev and y_prev values
        % get this value using idx from tree
        disp('Set Prev Values');
        tree.V(currIdx).xPrev = tree.V(prevIdx).x;
        tree.V(currIdx).yPrev = tree.V(prevIdx).y;
        % Check if new point valid or not
        % IS point in collision?
        if chkOBS(tree.V(currIdx).x,tree.V(currIdx).y,OBS) == 0 % yes its correct 0 IS always bad OK
            disp('Collision Detected');
            % skip iteration
            continue
        else
            disp('No Collision');
            % NO collision
            %IS path from prev to curr valid
            % IF crosChk()
            if chkCros(tree.V(currIdx).x,tree.V(currIdx).y,tree.V(currIdx).xPrev,tree.V(currIdx).yPrev,OBS)==1
                disp('Crossing Valid');
                tree.V(currIdx).flag = 1;
                prevIdx = currIdx;
                % ELSE continue;
            else
                disp('Cannot Cross');
                continue
            end
            
        end
        % Else skip loop iteration and try again
    else
        disp('Epsilon Invalid');
        continue;
    end
end
%%
pltRRT(0,0,100,100,xGoal,yGoal,rGoal,tree,OBS)