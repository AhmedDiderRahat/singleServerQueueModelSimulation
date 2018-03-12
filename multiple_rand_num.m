function ret = multiple_rand_num(m,n)

    ret = zeros(1,n);
        ret = unirand(37, 47, 37, 57, n);
        ret = floor(m*ret)+1;
    
    ret = ret';

end