* for ch2 
$constraint:CO2CCAP(r)$f_ccapr(r)
 (
  sum((fe,g)$(not sameas(g,"OIL")), AT(fe,g,r) * evd(fe,g,r) * emisf(fe))
   - (Y("ELE",r) * eleprod(r) - sum(g, AT("ELE",g,r) * evd("ELE",g,r)) + sum(nhw, YNHW(nhw,r) * nhwprod(nhw,r))) / 0.12 * ELEemisfactor(r)
  )  
  =E= ccapr(r);
* ================
i:PCARB(rs)$(cc(rs) and fe(i) and f_ccapr(rs))  q:bmkco2(i,g,rs)  p:pcarbb


* ================================
* for ch4  
$constraint:CO2CCAP(r)$f_ccapr(r)
 (
  sum((fe,g)$((not sameas(g,"OIL")) and (not sameas(g,'ELE'))), AT(fe,g,r) * evd(fe,g,r) * emisf(fe)) 
   + sum(g, AT("ELE",g,r) * evd("ELE",g,r) / 0.12 * ELEemisfactor(r))
  )  
  =E= ccapr(r);
* ================
i:PCARB(rs)$(cc(rs) and (fe(i) or ele(i) and (not fe(i) and ele(g))) and f_ccapr(rs))  q:bmkco2(i,g,rs)  p:pcarbb
