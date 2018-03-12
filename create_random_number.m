function ret = create_random_number(x0, a, c, m, n, l, h)
    
    arr = unirand(x0, a, c, m, n);
    
    for i = 1:n
       ret(i,1) = l + ceil( (h-l) * arr(i,1) );
       %ret(i,1) = arr(i,1);
    end
    
end


% x0 = seed, a=multiplier, c=increment, m=modulo, n=number of
% random_variable, l = lower_size, h=upper_size;