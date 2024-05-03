options ls = 150;

/*--- Using SAS formats */

/* Create `work.formats` catalog */
proc format lib = WORK cntlin = lib._RANDfmts_long;
run;

/* Merge rlong and slong tables */

data rs;
  merge lib.rlong_table lib.slong_table;
   by hhid pn studyyr;
run;

proc sort data=rs;
  by hhid subhh studyyr;
run;

/* one to many */
proc sort data = lib.hlong_table out =h;
by h_hhid studyyr;
run;

proc sort data=rs;
by h_hhid studyyr;
run;


data rsh;
  merge rs h;
  by h_hhid studyyr;
run;


proc sort data =rsh;
 by hhid pn studyyr;
run;

data out.mrg5_tables;
 merge rsh lib.rexit_table lib.rwide_table;
  by hhid pn;
run;


proc print data=out.mrg5_tables(obs=50);
run;


