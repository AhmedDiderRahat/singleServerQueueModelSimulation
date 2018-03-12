function ret = main_simulation()

    data03 = dlmread('input_file.txt');

    
    test = numel(data03);

    %answer = zeros(1,test+5);
    
    %minimum_cost = inventory_system_simulation(data03(1,1), data03(1,2), data03(1,3) );
    
    arr(1,:) = inventory_system_simulation(data03(1,1), data03(1,2), data03(1,3) );
    
    minimum_cost = arr(1,1);
    a = arr(1,2);
    b = arr(1,3);
    c = arr(1,4);
    
    x = data03(1,1);
    y = data03(1,2);
    z = data03(1,3);
    
    test = test/3;
    
    for i=2:test
        
        arr(1,:) = inventory_system_simulation(data03(i,1), data03(i,2), data03(i,3));
        %total_cost = inventory_system_simulation(data03(i,1), data03(i,2), data03(i,3));
        total_cost = arr(1,1);
        
        if total_cost < minimum_cost
            minimum_cost = total_cost;
           
             a = arr(1,2);
             b = arr(1,3);
             c = arr(1,4);
             
             x = data03(i,1);
             y = data03(i,2);
             z = data03(i,3);
            
        end
    end
    
    ret = [minimum_cost a b c x y z]; 

end