%MACRO LOGIT(TRAIN, Y, Y_TYPE, X, ID, T, WEIGHTS, SEED, WD);
title3 "LOGIT";
title4 "FITTING: LOGISTIC REGRESSION"; 
title5 "VARIABLE SELECTION: ALL";
proc logistic data=&TRAIN descending;
 model &Y = &X;
 %IF &WEIGHTS ne %THEN %DO; weight &WEIGHTS; %END;
 ods output ParameterEstimates=_MyCoef;
run;
data _null_;
 set _MyCoef end=eof;
 file "&WD\f_LOGIT.sas";
 if _n_ = 1 then put "p_LOGIT = 1/(1+exp(-1*(";
 if Variable="Intercept" then put Estimate;
 else put "+" Estimate "*" Variable ;
 if eof then put ")));" ;
run;
proc datasets lib=work; delete _: ; run; quit;
%MEND LOGIT;
