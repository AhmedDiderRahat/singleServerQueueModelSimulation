function ret = inter_demand_arrival_and_size(x0, a, c, m, n, dl, dh, sl, sh)
	
	%ret(:,1) = multiple_random_num(d,n);
	
	ret(:,1) = create_random_number(x0, a, c, m, n, dl, dh);
	
	
	%ret(:,2) = multiple_random_num(s,n);
	
	ret(:,2) = create_random_number(x0, a, c, m, n, sl, sh);
	
	dlmwrite('inter_demand_arrival_and_size.txt', ret,'delimiter','\t');
end

%dl= demandLow, dh=demandHigh, sl=sizeLow, sh=size_high