\S 100

gen:{[f;n]
 p: (neg n) ? n;
 outvec: p;
 while[count p > 1;
  i: floor 0.5 + f * count p;
	p: p[til i];
	outvec,: p;
 ];
 rindexes: (neg count outvec) ? count outvec;
 outvec[rindexes]
 };

n: 70000
stocks: gen[0.3;n]

quantities: 100 + (neg 9901) ? 9901;
prices: 50 + (neg 451) ? 451;

stock_prices: stocks
i: 0
while[i < n; index:(1?451)[0];stock_prices[i]:prices[index];i+: 1]

get_price:{[s]
 add: (1?2)[0];
 if[stock_prices[s] = 500;add: 0];
 if[stock_prices[s] = 50;add: 1];
 change: (1?5)[0] + 1;
 if[add = 0;change*: -1];
 stock_prices[s]+: change;
 if[stock_prices[s] < 50;stock_prices[s]: 50];
 if[stock_prices[s] > 500;stock_prices[s]: 500];
 stock_prices[s]
 };

i: 0
while[i < 10000000;stock:stocks[(1?count stocks)[0]];s,:stock;t,: i;q,:quantities[1?9901];p,:get_price[stock];i+:1]

trades:([]stock:s; time:t; quantity:q; price:p)

save `:trades.csv

// Note: The "where(stock < 10)" lines are only for the purpose of showing a truncated answer in the typescript file.
// a)
start: ltime .z.p
a: select thewavg:sum[price*quantity]%sum[quantity] by stock from (`time xasc trades)
(ltime .z.p) - start
select thewavg by stock where(stock < 10) from a
// b)
start: ltime .z.p
b: select themavg:mavg[10;price] by stock from (`time xasc trades)
(ltime .z.p) - start
select themavg by stock where(stock < 10) from b
// c)
start: ltime .z.p
c: select themwavg:msum[10;quantity*price]%msum[10;quantity] by stock from (`time xasc trades)
(ltime .z.p) - start
select themwavg by stock where(stock < 10) from c
// d)
//Show all stocks and all max profits: select distinct stock, max[price-mins[price]] by stock from (`time xasc trades)
// Show max profit from one specific stock, as mentioned in class:
start: ltime .z.p
select max[price-mins[price]] from (`time xasc trades) where stock = 1
(ltime .z.p) - start
\\