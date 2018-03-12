function ret = unirand(x0, a, c, m, n)

    ret = zeros(1,n);
    
    ret(1) =  mod ( ((a*x0) + c),  m) / m;
    
    for i=2:n
		ret(i) =  mod ( ( (a*ret(i-1) ) + c) , m) / m;
    end
	
	ret = ret';

end