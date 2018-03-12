function ret = inventory_system_simulation(s,S,n)

data01 = dlmread('inter_demand_arrival_and_size.txt');

data02 = dlmread('order_arrival_time.txt');

demand_time = zeros(1,(n+1)*30);
demand_time(1) = data01(1,1);

for i=2:n*30
    demand_time(i) = demand_time(i-1)+data01(i,1);
end

demand_size = data01(:,2);


order_arrival = zeros(1,n+2);

for i=1:n
    order_arrival(i) = (i-1)*30+data02(i);
end

I = 50; unit_price = 5; setup_cost = 30; unit_holding_cost = 1; unit_backlog_cost = 2;

ordering_cost = 0;
holding_size = 0;
backlog_size = 0;
holding_cost = 0;
backlog_cost = 0;

month_num = 0;
%month_num = 1;
event_time = 0;
event_type = 0;
event_size = 0;
event_num = 1;
order_num = 1;
order_size = 0;
demand_num = 1;
last_event_time = 0;
last_I_level = 0;

%ret = zeros((n+1)*30,4);

while month_num<=n %event_num<=5%
    last_event_time = event_time;
    
    last_I_level = I;
   
    if month_num==0   %month_num==0
        event = 'month_starts';
    elseif month_num==n
        event = 'month_ends';
    else
        if order_arrival(order_num)<=demand_time(demand_num)
            if order_arrival(order_num)<=month_num*30
                event = 'order_arrives';
            elseif demand_time(demand_num)<=month_num*30
                event = 'demand_arrives';
            else
                event = 'month_starts';
            end
        elseif demand_time(demand_num)<=month_num*30
            event = 'demand_arrives';
        else
            event = 'month_starts';
        end
    end

    
    
    switch event
        case 'month_starts'
            month_num = month_num+1;
            if I<s
                order_size = S-I;
                order_num = month_num;
            else
                order_size = 0;
                order_arrival(order_num) = n*30;
            end
            event_type = 0;
            event_time = (month_num-1)*30; %month_num-1
            event_size = -order_size;
            %month_num = month_num+1;
            if month_num<n&&order_size>0
                ordering_cost = ordering_cost+order_size*unit_price+setup_cost;
            end
            
        case 'demand_arrives'
            event_type = -1;
            event_time = demand_time(demand_num);
            event_size = demand_size(demand_num);
            I = I-demand_size(demand_num);
            demand_num = demand_num+1;
            
        case 'order_arrives'
            event_type = 1;
            event_time = order_arrival(order_num);
            event_size = order_size;
            I = I+order_size;
            order_num = order_num+1;
        
        case 'month_ends'
             %ordering_cost = ordering_cost-(order_size*unit_price+setup_cost);
             month_num = month_num+1;
             order_size = 0;
             event_size = 0;
             event_num = event_num-1;
             ordering_cost = ordering_cost/(n-1);
             holding_cost = (holding_size/(n-1))*unit_holding_cost;
             backlog_cost = (backlog_size/(n-1))*unit_backlog_cost;
             total_cost = ordering_cost+holding_cost+backlog_cost;
             %sprintf('Total Cost %d\nOrdering Cost: %d\nholding Cost: %d\nBacklog Cost: %d',total_cost,ordering_cost,holding_cost,backlog_cost)
             %sprintf('Holding Size: %d',holding_size)
             %sprintf('Backlog Size: %d',backlog_size)
             
    end
    if last_I_level>0
        holding_size = holding_size+(event_time-last_event_time)*last_I_level;
    elseif last_I_level<0
        backlog_size = backlog_size+(event_time-last_event_time)*last_I_level*(-1);
    end
    %holding_cost = holding_cost+
    %ret(event_num,:) = [event_type event_time event_size I];
    event_num = event_num+1;
end

ret = [total_cost ordering_cost holding_cost backlog_cost];
end







