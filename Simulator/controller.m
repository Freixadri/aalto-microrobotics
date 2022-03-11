function id = controller(maps,position,target)    
    % controller    Decides the id of the frequency that should be played.
    %               Usage:
    %
    %               id = controller(maps,position,target)
    %               
    %               maps is a struct array of length M and id should be
    %                  index to this array (1..M).
    %               position is the current position(s) of the particle(s)
    %               target is the current target(s) of the particle(s).
    %    
    %               The predicted movement of a particle after returning id
    %               is pnew = p + [maps(id).deltaX(p) maps(id).deltaY(p)].
    
    % TODO: Implement your controller here.
   
    %stuck=evalin('base','particle_stuck');      %Evaluate if the particle is stucked
    start = [0.7,0.3];
    global prevpos;                             % Global variable to store positions to compare in later iterations
    if position==start                          % Initialization of prevpos for the first iteration
        prevpos = start;
    end
    
    stuck=prevpos-position;                     % Difference between current position and previous one (indicator if particle is stuck)
    if stuck==0                                 % Particle is stuck
        id = randi([1,length(maps)]);           % Execute random frequency to unstuck the particle
    else                                        % Particle not stuck
         cost=zeros(1,59);                       % Defining cost variable
        %totalcost=zeros(1,59);
        for i=1:length(maps)                    % Compute for all possible frequences
            pnew = position + [maps(i).deltaX(position) maps(i).deltaY(position)] + maps(i).variance(position); % Calculate new position  
            opp=target(1)-pnew(1);cont=position(2)-pnew(2);                      % Vector lengths to calculate angle
            %cost(i) = atan2(opp,cont);                                          % Angle between movement vector and target      
            cost(i)=sqrt((pnew(1)-target(1))^2+(pnew(2)-target(2))^2);         % Distance from new position to target
            %totalcost(i) = 3*theta+cost;
        end
                       
        [ct,id]=min(cost);                     % Minimize cost function
        %[tcost,id]=min(totalcost);
    end
    prevpos = position;
end
        