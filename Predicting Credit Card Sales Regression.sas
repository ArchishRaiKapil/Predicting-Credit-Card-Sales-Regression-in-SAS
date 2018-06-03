libname c '/folders/myfolders/MEGA Case/Linear Regression/Linear Final v2.0';
/* Libname Statement*/

proc import datafile='/folders/myfolders/MEGA Case/Linear Regression/Linear Regression Case.xlsx'
out=c.Credit_Card dbms=xlsx replace ;
getnames=yes;
/* Importing Raw Data File */

data c.credit_card_step_1; 
set c.credit_card;
label
custid="Customer ID"
region="Geographic indicator"
townsize="Size of hometown"
gender="Gender"
age="Age in years"
agecat="Age category"
birthmonth="Birth month"
ed="Years of education"
edcat="Level of education"
jobcat="Job category"
union="Union member"
employ="Years with current employer"
empcat="Years with current employer"
retire="Retired"
income="Household income in thousands"
lninc="Log-income"
inccat="Income category in thousands"
debtinc="Debt to income ratio (x100)"
creddebt="Credit card debt in thousands"
lncreddebt="Log-credit card debt"
othdebt="Other debt in thousands"
lnothdebt="Log-Other debt"
default="Ever defaulted on a bank loan"
jobsat="Job satisfaction"
marital="Marital status"
spoused="Spouse years of education"
spousedcat="Spouse level of education"
reside="Number of people in household"
pets="Number of pets owned"
pets_cats="Number of cats owned"
pets_dogs="Number of dogs owned"
pets_birds="Number of birds owned"
pets_reptiles="Number of reptiles owned"
pets_small="Number of small animals owned"
pets_saltfish="Number of saltwater fish owned"
pets_freshfish="Number of freshwater fish owned"
homeown="Home ownership"
hometype="Building type"
address="Years at current address"
addresscat="Years at current address"
cars="Number of cars owned/leased"
carown="Primary vehicle lease/own"
cartype="Primary vehicle domestic/import"
carvalue="Primary vehicle sticker price"
carcatvalue="Primary vehicle price category"
carbought="Primary vehicle bought/leased within last year"
carbuy="Plan to purchase/lease vehicle within next year"
commute="Primary commute transportation"
commutecat="Commute category"
commutetime="Commute time in minutes"
commutecar="Used car to commute within last year"
commutemotorcycle="Used motorcycle to commute within last year"
commutecarpool="Used carpool to commute within last year"
commutebus="Used bus to commute within last year"
commuterail="Used train/subway to commute within last year"
commutepublic="Used other public transport to commute within last year"
commutebike="Used bike to commute within last year"
commutewalk="Walked to commute within last year"
commutenonmotor="Used other non-motorized transport to commute within last year"
telecommute="Telecommuted within last year"
reason="Primary reason for being a customer here"
polview="Political outlook"
polparty="Political party membership"
polcontrib="Political contributions"
vote="Voted in last election"
card="Primary credit card"
cardtype="Designation of primary credit card"
cardbenefit="Benefit program for primary credit card"
cardfee="Annual fee for primary credit card"
cardtenure="Years held primary credit card"
cardtenurecat="Years held primary credit card"
card2="Secondary credit card"
card2type="Designation of secondary credit card"
card2benefit="Benefit program for secondary credit card"
card2fee="Annual fee for secondary credit card"
card2tenure="Years held secondary credit card"
card2tenurecat="Years held secondary credit card"
carditems="Number of items on primary card last month"
cardspent="Amount spent on primary card last month"
card2items="Number of items on secondary card last month"
card2spent="Amount spent on secondary card last month"
active="Active lifestyle"
bfast="Preferred breakfast"
tenure="Number of months with service"
churn="Switched providers within last month"
longmon="Long distance last month"
lnlongmon="Log-long distance last month"
longten="Long distance over tenure"
lnlongten="Log-long distance over tenure"
tollfree="Toll free service"
tollmon="Toll-free last month"
lntollmon="Log-toll free last month"
tollten="Toll-free over tenure"
lntollten="Log-toll free over tenure"
equip="Equipment rental"
equipmon="Equipment last month"
lnequipmon="Log-equipment last month"
equipten="Equipment over tenure"
lnequipten="Log-equipment over tenure"
callcard="Calling card service"
cardmon="Calling card last month"
lncardmon="Log-calling card last month"
cardten="Calling card over tenure"
lncardten="Log-calling card over tenure"
wireless="Wireless service"
wiremon="Wireless last month"
lnwiremon="Log-wireless last month"
wireten="Wireless over tenure"
lnwireten="Log-wireless over tenure"
multline="Multiple lines"
voice="Voice mail"
pager="Paging service"
internet="Internet"
callid="Caller ID"
callwait="Call waiting"
forward="Call forwarding"
confer="3-way calling"
ebill="Electronic billing"
owntv="Owns TV"
hourstv="Hours spent watching TV last week"
ownvcr="Owns VCR"
owndvd="Owns DVD player"
owncd="Owns stereo/CD player"
ownpda="Owns PDA"
ownpc="Owns computer"
ownipod="Owns portable digital audio player"
owngame="Owns gaming system"
ownfax="Owns fax machine"
news="Newspaper subscription"
response_01="Response to product offer 01"
response_02="Response to product offer 02"
response_03="Response to product offer 03"
;
/*Adding labels to the dataset*/
run;

data c.credit_card_step_1;
set c.credit_card_step_1;
Y=cardspent+card2spent;
/* Creating the Y variable*/
run;

data c.credit_card_step_2;
set c.credit_card_step_1;
if income>272.5 then income=272.5;
if debtinc>29.2 then debtinc=29.2;
if creddebt>14.29792 then creddebt=14.29792;
if othdebt>24.153048 then othdebt=24.153048;
if cardspent>1216.16 then cardspent=1216.16;
if card2spent>713.59 then card2spent=713.59;
if longmon>65.25 then longmon=65.25;
if longten>4721.85 then longten=4721.85;
if tollmon>58.875 then tollmon=58.875;
if tollten>3983.18 then tollten=3983.18;
if equipmon>63.325 then equipmon=63.325;
if equipten>3679.825 then equipten=3679.825;
if cardmon>64.25 then cardmon=64.25;
if cardten>4050 then cardten=4050;
if wiremon>78.5 then wiremon=78.5;
if wireten>4534.4 then wireten=4534.4;
if Y>1764.63 then Y=1764.63;
/* Outlier Treatment done at 99 percentile (values obtained from proc univariate)*/
run;

data c.credit_card_step_3;
set c.credit_card_step_2;
/*Continous Variables*/
if age=. then age=47.0256;
if card2items=. then card2items=4.6666;
if card2spent=. then card2spent=158.616118;
if carditems=. then carditems=10.1774;
if cardmon=. then cardmon=15.26695;
if cardspent=. then cardspent=333.40733;
if cardten=. then cardten=707.6272509;
if carvalue=. then carvalue=23.23258;
if commutetime=. then commutetime=25.3455382;
if creddebt=. then creddebt=1.7584067;
if debtinc=. then debtinc=9.91152;
if ed=. then ed=14.543;
if equipmon=. then equipmon=12.90896;
if equipten=. then equipten=463.40207;
if hourstv=. then hourstv=19.645;
if income=. then income=53.6348;
if lncardmon=. then lncardmon=2.9097327;
if lncardten=. then lncardten=6.4263087;
if lncreddebt=. then lncreddebt=-0.1304535;
if lnequipmon=. then lnequipmon=3.6002376;
if lnequipten=. then lnequipten=6.7472964;
if lninc=. then lninc=3.6999094;
if lnlongmon=. then lnlongmon=2.2887792;
if lnlongten=. then lnlongten=5.6112979;
if lnothdebt=. then lnothdebt=0.6969153;
if lntollmon=. then lntollmon=3.2432298;
if lntollten=. then lntollten=6.5847833;
if lnwiremon=. then lnwiremon=3.6050007;
if lnwireten=. then lnwireten=6.808132;
if longmon=. then longmon=13.26964;
if longten=. then longten=694.6440064;
if othdebt=. then othdebt=3.5229855;
if pets=. then pets=3.0674;
if pets_birds=. then pets_birds=0.1104;
if pets_cats=. then pets_cats=0.5004;
if pets_dogs=. then pets_dogs=0.3924;
if pets_freshfish=. then pets_freshfish=1.8474;
if pets_reptiles=. then pets_reptiles=0.0556;
if pets_saltfish=. then pets_saltfish=0.0466;
if pets_small=. then pets_small=0.1146;
if reside=. then reside=2.204;
if spoused=. then spoused=6.1128;
if tenure=. then tenure=38.2048;
if tollmon=. then tollmon=13.1413;
if tollten=. then tollten=570.18929;
if wiremon=. then wiremon=10.53223;
if wireten=. then wireten=410.00216;
/*Categorical Variables*/
if active=. then active=0;
if address=. then address=0;
if addresscat=. then addresscat=3;
if agecat=. then agecat=4;
if bfast=. then bfast=3;
if birthmonth="." then birthmonth="September";
if callcard=. then callcard=1;
if callid=. then callid=0;
if callwait=. then callwait=0;
if carbought=. then carbought=0;
if carbuy=. then carbuy=0;
if carcatvalue=. then carcatvalue=1;
if card=. then card=4;
if card2=. then card2=3;
if card2benefit=. then card2benefit=4;
if card2fee=. then card2fee=0;
if card2tenure=. then card2tenure=2;
if card2tenurecat=. then card2tenurecat=5;
if card2type=. then card2type=4;
if cardbenefit=. then cardbenefit=3;
if cardfee=. then cardfee=0;
if cardtenure=. then cardtenure=3;
if cardtenurecat=. then cardtenurecat=5;
if cardtype=. then cardtype=4;
if carown=. then carown=1;
if cars=. then cars=2;
if cartype=. then cartype=0;
if churn=. then churn=0;
if commute=. then commute=1;
if commutebike=. then commutebike=0;
if commutebus=. then commutebus=0;
if commutecar=. then commutecar=1;
if commutecarpool=. then commutecarpool=0;
if commutecat=. then commutecat=1;
if commutemotorcycle=. then commutemotorcycle=0;
if commutenonmotor=. then commutenonmotor=0;
if commutepublic=. then commutepublic=0;
if commuterail=. then commuterail=0;
if commutewalk=. then commutewalk=0;
if confer=. then confer=0;
if default=. then default=0;
if ebill=. then ebill=0;
if edcat=. then edcat=2;
if empcat=. then empcat=2;
if employ=. then employ=0;
if equip=. then equip=0;
if forward=. then forward=0;
if gender=. then gender=1;
if homeown=. then homeown=1;
if hometype=. then hometype=1;
if inccat=. then inccat=2;
if internet=. then internet=0;
if jobcat=. then jobcat=2;
if jobsat=. then jobsat=3;
if marital=. then marital=0;
if multline=. then multline=0;
if news=. then news=0;
if owncd=. then owncd=1;
if owndvd=. then owndvd=1;
if ownfax=. then ownfax=0;
if owngame=. then owngame=0;
if ownipod=. then ownipod=0;
if ownpc=. then ownpc=1;
if ownpda=. then ownpda=0;
if owntv=. then owntv=1;
if ownvcr=. then ownvcr=1;
if pager=. then pager=0;
if polcontrib=. then polcontrib=0;
if polparty=. then polparty=0;
if polview=. then polview=4;
if reason=. then reason=9;
if region=. then region=5;
if response_01=. then response_01=0;
if response_02=. then response_02=0;
if response_03=. then response_03=0;
if retire=. then retire=0;
if spousedcat=. then spousedcat=-1;
if telecommute=. then telecommute=0;
if tollfree=. then tollfree=0;
if townsize=. then townsize=1;
if union=. then union=0;
if voice=. then voice=0;
if vote=. then vote=1;
if wireless=. then wireless=0;
/* mean and mode - missing value imputation*/
run;

proc univariate data=c.credit_card_step_3;
var y;
histogram;
/*Checking whether there is a need to transform the Y variable or not*/
run;

data c.credit_card_step_4;
set c.credit_card_step_3;
ln_y=log(y);
/* Transforming the Y variable */
run;

proc univariate data=c.credit_card_step_4;
var y ln_y;
histogram;
/* Checking the distrubution of log Y*/
run;


/*********************************************************************************************************/
/*Creation of dummy Variables (Initially dummy Variables were created even for Binary Categorical 
and Categorical Variables with too many many Categories. Later the code was ratifidied and now the
following syntax has dummy variables created with categores upto 10*/

DATA c.credit_card_with_dummy; SET c.credit_card_step_4; if cars=0 then cars_d_0=1; else cars_d_0=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cars=1 then cars_d_1=1; else cars_d_1=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cars=2 then cars_d_2=1; else cars_d_2=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cars=3 then cars_d_3=1; else cars_d_3=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cars=4 then cars_d_4=1; else cars_d_4=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cars=5 then cars_d_5=1; else cars_d_5=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cars=6 then cars_d_6=1; else cars_d_6=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cars=7 then cars_d_7=1; else cars_d_7=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if carown=-1 then carown_d_NA=1; else carown_d_NA=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if carown=0 then carown_d_Lease=1; else carown_d_Lease=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cartype=-1 then cartype_d_NA=1; else cartype_d_NA=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cartype=0 then cartype_d_Domestic=1; else cartype_d_Domestic=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if carcatvalue=-1 then carcatvalue_d_NA=1; else carcatvalue_d_NA=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if carcatvalue=1 then carcatvalue_d_Economy=1; else carcatvalue_d_Economy=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if carcatvalue=2 then carcatvalue_d_Standard=1; else carcatvalue_d_Standard=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if carbought=-1 then carbought_d_NA=1; else carbought_d_NA=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if carbought=0 then carbought_d_No=1; else carbought_d_No=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if reason=1 then reason_d_Prices=1; else reason_d_Prices=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if reason=2 then reason_d_Convenience=1; else reason_d_Convenience=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if reason=3 then reason_d_Service=1; else reason_d_Service=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if reason=4 then reason_d_Other=1; else reason_d_Other=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if reason=8 then reason_d_NA=1; else reason_d_NA=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if polview=1 then polview_d_Extremely_liberal=1; else polview_d_Extremely_liberal=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if polview=2 then polview_d_Liberal=1; else polview_d_Liberal=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if polview=3 then polview_d_Slightly_liberal=1; else polview_d_Slightly_liberal=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if polview=4 then polview_d_Moderate=1; else polview_d_Moderate=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if polview=5 then polview_d_Slightly_conservative=1; else polview_d_Slightly_conservative=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if polview=6 then polview_d_Conservative=1; else polview_d_Conservative=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card=1 then card_d_American_Express=1; else card_d_American_Express=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card=2 then card_d_Visa=1; else card_d_Visa=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card=3 then card_d_Mastercard=1; else card_d_Mastercard=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card=4 then card_d_Discover=1; else card_d_Discover=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardtype=1 then cardtype_d_None=1; else cardtype_d_None=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardtype=2 then cardtype_d_Gold=1; else cardtype_d_Gold=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardtype=3 then cardtype_d_Platinum=1; else cardtype_d_Platinum=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardbenefit=1 then cardbenefit_d_None=1; else cardbenefit_d_None=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardbenefit=2 then cardbenefit_d_Cash_back=1; else cardbenefit_d_Cash_back=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardbenefit=3 then cardbenefit_d_Airline_miles=1; else cardbenefit_d_Airline_miles=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2=1 then card2_d_American_Express=1; else card2_d_American_Express=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2=2 then card2_d_Visa=1; else card2_d_Visa=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2=3 then card2_d_Mastercard=1; else card2_d_Mastercard=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2=4 then card2_d_Discover=1; else card2_d_Discover=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2type=1 then card2type_d_None=1; else card2type_d_None=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2type=2 then card2type_d_Gold=1; else card2type_d_Gold=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2type=3 then card2type_d_Platinum=1; else card2type_d_Platinum=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2benefit=1 then card2benefit_d_None=1; else card2benefit_d_None=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2benefit=2 then card2benefit_d_Cash_back=1; else card2benefit_d_Cash_back=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2benefit=3 then card2benefit_d_Airline_miles=1; else card2benefit_d_Airline_miles=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if bfast=1 then bfast_d_Energy_bar=1; else bfast_d_Energy_bar=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if bfast=2 then bfast_d_Oatmeal=1; else bfast_d_Oatmeal=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if internet=0 then internet_d_None=1; else internet_d_None=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if internet=1 then internet_d_Dial_up=1; else internet_d_Dial_up=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if internet=2 then internet_d_DSL=1; else internet_d_DSL=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if internet=3 then internet_d_Cable_modem=1; else internet_d_Cable_modem=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if empcat=1 then empcat_d_Less_than_2=1; else empcat_d_Less_than_2=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if empcat=2 then empcat_d_2_to_5=1; else empcat_d_2_to_5=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if empcat=3 then empcat_d_6_to_10=1; else empcat_d_6_to_10=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if empcat=4 then empcat_d_11_to_15=1; else empcat_d_11_to_15=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if inccat=1 then inccat_d_Under_25=1; else inccat_d_Under_25=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if inccat=2 then inccat_d_25_to_49=1; else inccat_d_25_to_49=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if inccat=3 then inccat_d_50_to_74=1; else inccat_d_50_to_74=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if inccat=4 then inccat_d_75_to_124=1; else inccat_d_75_to_124=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if jobsat=1 then jobsat_d_Highly_dissatisfied=1; else jobsat_d_Highly_dissatisfied=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if jobsat=2 then jobsat_d_Somewhat_dissatisfied=1; else jobsat_d_Somewhat_dissatisfied=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if jobsat=3 then jobsat_d_Neutral=1; else jobsat_d_Neutral=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if jobsat=4 then jobsat_d_Somewhat_satisfied=1; else jobsat_d_Somewhat_satisfied=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if spousedcat=-1 then spousedcat_d_Not_married=1; else spousedcat_d_Not_married=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if spousedcat=1 then spousedcat_d_Not_complete_school=1; else spousedcat_d_Not_complete_school=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if spousedcat=2 then spousedcat_d_High_school_degree=1; else spousedcat_d_High_school_degree=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if spousedcat=3 then spousedcat_d_Some_college=1; else spousedcat_d_Some_college=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if spousedcat=4 then spousedcat_d_College_degree=1; else spousedcat_d_College_degree=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if hometype=1 then hometype_d_Single_family=1; else hometype_d_Single_family=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if hometype=2 then hometype_d_Multiple_Family=1; else hometype_d_Multiple_Family=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if hometype=3 then hometype_d_Condominium_Townhouse=1; else hometype_d_Condominium_Townhouse=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if addresscat=1 then addresscat_d_Less_than_3=1; else addresscat_d_Less_than_3=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if addresscat=2 then addresscat_d_4_to_7=1; else addresscat_d_4_to_7=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if addresscat=3 then addresscat_d_8_to_15=1; else addresscat_d_8_to_15=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if addresscat=4 then addresscat_d_16_to_25=1; else addresscat_d_16_to_25=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=1 then commute_d_Car=1; else commute_d_Car=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=2 then commute_d_Motorcycle=1; else commute_d_Motorcycle=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=3 then commute_d_Carpool=1; else commute_d_Carpool=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=4 then commute_d_Bus=1; else commute_d_Bus=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=5 then commute_d_Train_Subway=1; else commute_d_Train_Subway=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=6 then commute_d_Other_public_transit=1; else commute_d_Other_public_transit=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=7 then commute_d_Bicycle=1; else commute_d_Bicycle=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=8 then commute_d_Walk=1; else commute_d_Walk=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commute=9 then commute_d_Other_non_motor=1; else commute_d_Other_non_motor=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commutecat=1 then commutecat_d_Single_occupancy=1; else commutecat_d_Single_occupancy=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commutecat=2 then commutecat_d_Multiple_occupancy=1; else commutecat_d_Multiple_occupancy=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commutecat=3 then commutecat_d_Public_transport=1; else commutecat_d_Public_transport=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if commutecat=4 then commutecat_d_Non_motorized=1; else commutecat_d_Non_motorized=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardtenurecat=1 then cardtenurecat_d_Less_than_2=1; else cardtenurecat_d_Less_than_2=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardtenurecat=2 then cardtenurecat_d_2_to_5=1; else cardtenurecat_d_2_to_5=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardtenurecat=3 then cardtenurecat_d_6_to_10=1; else cardtenurecat_d_6_to_10=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if cardtenurecat=4 then cardtenurecat_d_11_to_15=1; else cardtenurecat_d_11_to_15=0; run;

DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2tenurecat=1 then card2tenurecat_d_Less_than_2=1; else card2tenurecat_d_Less_than_2=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2tenurecat=2 then card2tenurecat_d_2_to_5=1; else card2tenurecat_d_2_to_5=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2tenurecat=3 then card2tenurecat_d_6_to_10=1; else card2tenurecat_d_6_to_10=0; run;
DATA c.credit_card_with_dummy; SET c.credit_card_with_dummy; if card2tenurecat=4 then card2tenurecat_d_11_to_15=1; else card2tenurecat_d_11_to_15=0; run;

/*dummy- JOBCAT*/
data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if jobcat=1 then jobcat_d_Managerial_Professional=1;
else jobcat_d_Managerial_Professional=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if jobcat=2 then jobcat_d_Sales_Office=1;
else jobcat_d_Sales_Office=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if jobcat=3 then jobcat_d_Service=1;
else jobcat_d_Service=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if jobcat=4 then jobcat_d_Agri_Natural_Resources=1;
else jobcat_d_Agri_Natural_Resources=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if jobcat=5 then jobcat_d_Precision_Craft_Repair=1;
else jobcat_d_Precision_Craft_Repair=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if jobcat=6 then jobcat_d_Opr_Fabric_Labor=1;
else jobcat_d_Opr_Fabric_Labor=0;
run;

/*dummy- REGION*/
data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if region=1 then region_d_zone1=1;
else region_d_zone1=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if region=2 then region_d_zone2=1;
else region_d_zone2=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if region=3 then region_d_zone3=1;
else region_d_zone3=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if region=4 then region_d_zone4=1;
else region_d_zone4=0;
run;

/*dummy- TOWN SIZE*/
data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if townsize=1 then townsize_d_1=1;
else townsize_d_1=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if townsize=2 then townsize_d_2=1;
else townsize_d_2=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if townsize=3 then townsize_d_3=1;
else townsize_d_3=0;
run;

data c.credit_card_with_dummy;
set c.credit_card_with_dummy;
if townsize=4 then townsize_d_4=1;
else townsize_d_4=0;
run;


/*********************************** DUMMY VARIABLES CREATED **********************************************/


/* Factor Analysis on Continious Variables *****/

ods html file='/folders/myfolders/MEGA Case/Linear Regression/Linear Final/factor analysis.xls';
PROC FACTOR  data=c.credit_card_with_dummy
method=principal scree mineigen=0 nfactor=16 rotate=varimax reorder out=factor;
var
age
card2items
carditems
cardmon
cardten
carvalue
commutetime
creddebt
debtinc
ed
equipmon
equipten
hourstv
income
lncardmon
lncardten
lncreddebt
lnequipmon
lnequipten
lninc
lnlongmon
lnlongten
lnothdebt
lntollmon
lntollten
lnwiremon
lnwireten
longmon
longten
othdebt
pets
pets_birds
pets_cats
pets_dogs
pets_freshfish
pets_reptiles
pets_saltfish
pets_small
reside
spoused
tenure
tollmon
tollten
wiremon
wireten
;
run;
ods _all_ close;



/*Variable Reduction of dummy variables-  Two sample T test*/
/*
proc ttest data=c.credit_card_with_dummy;  class addresscat_d_16_to_25;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class addresscat_d_4_to_7;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class addresscat_d_8_to_15;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class addresscat_d_Less_than_3;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class bfast_d_Energy_bar;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class bfast_d_Oatmeal;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carbought_d_NA;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carbought_d_No;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carcatvalue_d_Economy;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carcatvalue_d_NA;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carcatvalue_d_Standard;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card_d_American_Express;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card_d_Discover;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card_d_Mastercard;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card_d_Visa;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2_d_American_Express;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2_d_Discover;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2_d_Mastercard;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2_d_Visa;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2benefit_d_Airline_miles;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2benefit_d_Cash_back;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2benefit_d_None;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2tenurecat_d_11_to_15;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2tenurecat_d_2_to_5;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2tenurecat_d_6_to_10;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2tenurecat_d_Less_than_2;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2type_d_Gold;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2type_d_None;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2type_d_Platinum;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardbenefit_d_Airline_miles;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardbenefit_d_Cash_back;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardbenefit_d_None;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtenurecat_d_11_to_15;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtenurecat_d_2_to_5;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtenurecat_d_6_to_10;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtenurecat_d_Less_than_2;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardbenefit_d_Airline_miles;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardbenefit_d_Cash_back;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardbenefit_d_None;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtenurecat_d_11_to_15;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtenurecat_d_2_to_5;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtenurecat_d_6_to_10;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtenurecat_d_Less_than_2;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtype_d_Gold;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtype_d_None;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardtype_d_Platinum;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carown_d_Lease;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carown_d_NA;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cars_d_0;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cars_d_1;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cars_d_2;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cars_d_3;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cars_d_4;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cars_d_5;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cars_d_6;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cars_d_7;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cartype_d_Domestic;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cartype_d_NA;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carown_d_Lease;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carown_d_NA;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cartype_d_Domestic;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cartype_d_NA;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Bicycle;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Bus;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Car;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Carpool;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Motorcycle;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Other_non_motor;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Other_public_transit;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Train_Subway;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commute_d_Walk;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutecat_d_Multiple_occupancy;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutecat_d_Non_motorized;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutecat_d_Public_transport;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutecat_d_Single_occupancy;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class empcat_d_11_to_15;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class empcat_d_2_to_5;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class empcat_d_6_to_10;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class empcat_d_Less_than_2;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class hometype_d_Condominium_Townhouse;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class hometype_d_Multiple_Family;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class hometype_d_Single_family;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class inccat_d_25_to_49;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class inccat_d_50_to_74;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class inccat_d_75_to_124;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class inccat_d_Under_25;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class internet_d_Cable_modem;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class internet_d_Dial_up;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class internet_d_DSL;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class internet_d_None;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobcat_d_Agri_Natural_Resources;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobcat_d_Managerial_Professional;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobcat_d_Opr_Fabric_Labor;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobcat_d_Precision_Craft_Repair;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobcat_d_Sales_Office;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobcat_d_Service;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobsat_d_Highly_dissatisfied;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobsat_d_Neutral;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobsat_d_Somewhat_dissatisfied;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class jobsat_d_Somewhat_satisfied;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class polview_d_Conservative;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class polview_d_Extremely_liberal;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class polview_d_Liberal;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class polview_d_Moderate;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class polview_d_Slightly_conservative;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class polview_d_Slightly_liberal;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class reason_d_Convenience;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class reason_d_NA;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class reason_d_Other;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class reason_d_Prices;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class reason_d_Service;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class region_d_zone1;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class region_d_zone2;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class region_d_zone3;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class region_d_zone4;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class spousedcat_d_College_degree;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class spousedcat_d_High_school_degree;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class spousedcat_d_Not_complete_school;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class spousedcat_d_Not_married;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class spousedcat_d_Some_college;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class townsize_d_1;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class townsize_d_2;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class townsize_d_3;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class townsize_d_4;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class union;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class active;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class callcard;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class callid;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class callwait;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class carbuy;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class card2fee;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class cardfee;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class churn;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutebike;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutebus;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutecar;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutecarpool;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutemotorcycle;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutenonmotor;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutepublic;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commuterail;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class commutewalk;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class confer;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class default;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class ebill;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class equip;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class forward;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class homeown;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class marital;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class multline;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class news;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class owncd;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class owndvd;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class ownfax;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class owngame;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class ownipod;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class ownpc;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class ownpda;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class owntv;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class ownvcr;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class pager;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class polcontrib;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class polparty;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class response_01;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class response_02;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class response_03;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class retire;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class telecommute;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class tollfree;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class voice;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class vote;  var ln_y ; RUN;
proc ttest data=c.credit_card_with_dummy;  class wireless;  var ln_y ; RUN;

/*************   Spliting Data  *************/
proc surveyselect
data=c.credit_card_with_dummy
out=c.linear_splitter
outall
samprate=0.7
seed=123;
run;

data c.linear_model c.linear_to_validate;
set c.linear_splitter;
if selected=1 then output c.linear_model;
else output c.linear_to_validate;
RUN;


/*************Iteration*******************/
proc reg
data=c.linear_model;
model
ln_y
=
card_d_American_Express
card_d_Discover
card2_d_American_Express
reason_d_Convenience
reason_d_Prices
age
lninc
ed
card2items
carditems
/
slentry=0.1
VIF
STB
;
run;

/******Validation on validation dataset********/

data c.linear_to_validate_out;
set c.linear_to_validate;
predicted_Y=
(
(card_d_American_Express*0.45709)+
(card_d_Discover*-0.05158)+
(card2_d_American_Express*0.2664)+
(reason_d_Convenience*0.21109)+
(reason_d_Prices*-0.11277)+
(age*-0.00115)+
(lninc*0.28864)+
(ed*-0.00551)+
(card2items*0.10677)+
(carditems*0.08256)
)
+3.60418
;
predicted_Y=Exp(predicted_Y);
run;

proc rank 
data=c.linear_to_validate_out
out=c.linear_to_validate_out
ties=low
descending
groups=10;
var predicted_y;
ranks decile;
run;

proc sql;
create table val1
as select
decile,
mean(Y) as Average_Y,
mean(predicted_y) as Avg_predicted_y,
sum(Y) as Total_Y,
sum(predicted_y) as Total_predicted_y
from c.linear_to_validate_out
group by decile
;



/******Validation Model dataset********/

data c.linear_model_out;
set c.linear_model;
predicted_Y=
(
(card_d_American_Express*0.45709)+
(card_d_Discover*-0.05158)+
(card2_d_American_Express*0.2664)+
(reason_d_Convenience*0.21109)+
(reason_d_Prices*-0.11277)+
(age*-0.00115)+
(lninc*0.28864)+
(ed*-0.00551)+
(card2items*0.10677)+
(carditems*0.08256)
)
+3.60418
;
predicted_Y=Exp(predicted_Y);
run;

proc rank 
data=c.linear_model_out
out=c.linear_model_out
ties=low
descending
groups=10;
var predicted_y;
ranks decile;
run;

proc sql;
create table mod1
as select
decile,
mean(Y) as Average_Y,
mean(predicted_y) as Avg_predicted_y,
sum(Y) as Total_Y,
sum(predicted_y) as Total_predicted_y
from c.linear_model_out
group by decile
;







