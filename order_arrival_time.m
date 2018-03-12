function ret = order_arrival_time(x0, a, c, m, n, ol, oh)

    ret = create_random_number(x0, a, c, m, n, ol, oh);

    dlmwrite('order_arrival_time.txt',ret,'\t');
    
end