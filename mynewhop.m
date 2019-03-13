function fc = mynewhop(m,n)
net = newhop(m);
fc = sim(net,{1,30},{},n);