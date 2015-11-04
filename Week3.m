
% INITIALIZATION

% global start time 
start_time = 1;

% global end time 
steps = 100;   

% step size
delta_t = 0.1; 

% update
update = 0.5;

% number of agents
number_agents = 5;

% Make a random field
state = zeros(number_agents,steps); 

% calculating chance by given an percentage for zero
chanceZero = 0.4;

% Initial Values
for agents = 1:number_agents
    state(agents,1) = rand(1);
end


% make aggimpact

aggimpact = double(number_agents);

% CREATE VARIABLE CONTAINING CONNECTION WEIGHTS FOR THE CONNECTIONS BETWEEN
% AGENTS

% calculating chance by given a percentagemore than zero
chanceRest = ((1-chanceZero)/9); 

%make a vector with random numbers given by number of agents
r=rand(number_agents); 

% make probability vector
prob=[chanceZero,chanceRest,chanceRest,chanceRest,chanceRest,chanceRest,chanceRest,chanceRest,chanceRest,chanceRest,chanceRest];
prob = cumsum(prob);
% values corresponding to the probabilities
value=[0,.1,.2,.3,.4,.5,.6,.7,.8,.9,1];   

% calculate weights
weights = arrayfun(@(z)(value(find(z<=prob,1,'first'))), r);
  

%CALCULATING STATES OF AGENTS

% initializing time
time = start_time + delta_t;

% finding the scalefactor without subtracting own value for an given agent
sumColumn = ((sum(weights,1)));

% find the overall sum of the given row without subtracting own value for an given agent
sumRow = ((sum(weights,2))); 


for agents = 1:number_agents
    % calculate the aggimpact (Sum from Row - own value)/ SumColumn - own value
   aggimpact(agents) = ((sumRow(agents) - weights(agents,agents))/(sumColumn(agents)-weights(agents,agents)));
end   

% calculating new states of agent
%initializing step
stateNumber = 2;
intermediate_state = zeros(number_agents);
intermediate_state(agents) = state(agents,1);
while start_time < steps 
    step = 1;
   
    for agents = 1:number_agents
        
    end
    
    while step <= 10 
        start_time = start_time + delta_t;
        for agents = 1:number_agents
        % update rule state(t+delta_t) = state(t)(update(aggimpact(choosen agent)delta_t
        
        % applying the update rule
            intermediate_state(agents) = intermediate_state(agents)+(update*aggimpact(agents)-intermediate_state(agents))*delta_t;  
        end
        % higher step
        step = step + 1;
       
    end
    
    for agents = 1:number_agents
        % When the state of a agent is bigger than 1,make the state 1.
        if intermediate_state(agents) > 1
            intermediate_state(agents) = 1;
        end
            
         state(agents,stateNumber) = intermediate_state(agents);

    end
    
    stateNumber = stateNumber + 1;
end

% MAKE A PLOT

% make a output Variable
output = zeros(number_agents,steps);

% make for every agent another color for the plot
cmap = hsv(number_agents);

% Setting Stepsize for every point on plot
x = 0:1:steps-1;

% printing a plot with the states


% convert given states to an output
for i=1:number_agents
    for t = 1:steps
    eval(sprintf('output_a%d(%d) = state(%d,%d)', i,t,i,t));
    end
end

% finally print plot
hold on;
for output= 1:number_agents
    subplot(3,2,output);
    eval(sprintf('plot(x,output_a%d,''-s'',''Color'',cmap(output,:))',output)); 
    eval(sprintf('title(''Agent %d'')',output));
end
hold off;

