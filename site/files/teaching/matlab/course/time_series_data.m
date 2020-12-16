%% Time Series Data
% This program imports the data requires in the time series component of the 
% MATLAB course.
%% Clear the environment
% It is a good idea to clear all variables and close all figures before proceeding
%%
clear all
close all
clc
%% Government and Corporate Yields
% The data on GS1 and GS10 were downloaded from FRED. All series have been cleaned 
% in Excel which contains two columns - dates and values where the dates have 
% Excel numeric format.
%%
% Read the data
gs_1 = table2timetable(readtable('GS1.xls', 'Range','A11:B800'))
gs_10 = table2timetable(readtable('GS10.xls', 'Range','A11:B800'))
% Define the using the indices of the common locations
term = gs_10.GS10 - gs_1.GS1;
term_table = timetable(gs_10.Properties.RowTimes, term)
dates = gs_10.Properties.RowTimes;
mldates = datenum(dates);    
% Save the dataset
save term term dates mldates gs_1 gs_10 term_table 
 
% Read the data
baa = table2timetable(readtable('BAA.xls', 'Range','A11:B1211'))
aaa = table2timetable(readtable('AAA.xls', 'Range','A11:B1211'))
% Define the using the indices of the common locations
def = baa.BAA - aaa.AAA;
dates = baa.Properties.RowTimes;
def_table = timetable(dates, def)
mldates = datenum(dates);
% Save the dataset
save def def baa aaa def def_table mldates dates
%% UK CPI Data
% Monthly for the UK CPI was taken from the ONS's site, and was formatted in 
% Excel to have standard dates, values, and only 1 header line with variable names.
%%
% Read the data
cpi_table = table2timetable(readtable('UK_CPI.xls', 'Range','A1:B360'))
dates = cpi_table.Properties.RowTimes;
% Construct ML dates 
mldates = datenum(dates);
% Pull out the CPI
cpi = cpi_table.CPIH;
% Save the dataset
save cpi cpi mldates dates cpi_table
%% SP500
% The S&P 500 date was downloaded from Yahoo.  The warning appears since the 
% column names have spaces which are not allowed.
%%
sp500_table = table2timetable(readtable('sp500.xlsx'))
dates = sp500_table.Properties.RowTimes;
mldates = datenum(dates);
% Pull out the Index
sp500 = sp500_table.AdjClose;
% Save the dataset
save sp500 sp500 mldates dates sp500_table
%% EURUSD
% The data for this data set was downloaded from www.ofx.com.
%%
eurusd_table = table2timetable(readtable('eurusd.xlsx'))
dates = eurusd_table.Properties.RowTimes;
mldates = datenum(dates);
% Pull out the FX rate
eurusd = eurusd_table.EURUSD;
% Save the dataset
save eurusd eurusd mldates dates eurusd_table 
%% VAR Data
% Each of the three data sets required for the VAR exercises was downloaded 
% and loaded into tables.  The only modification needed to to change the month 
% in the quarterly dataset to be end-of-quarter rather than start. The final dataset 
% uses |join| the merge the interest rate series and innerjoin to merge the GDP 
% deflator.  The joins merge on the index, and |innerjoin| only keeps the common 
% set.  This is similar to a SQL inner join. 
%%
gdpdef = table2timetable(readtable('GDPDEF.xls', 'Range','A11:B298'))
dates = gdpdef.Properties.RowTimes;
% Move to end of quarter month instead of start
for i = 1:length(dates)
    dates(i).Month = dates(i).Month+2;
end
dates
% Difference the data
gdpdef.GDPDEF(2:end) = gdpdef.GDPDEF(2:end) - gdpdef.GDPDEF(1:end-1);
gdpdef.GDPDEF(1) = nan;
VAR_data = innerjoin(gdpdef, join(gs_1, gs_10))
VAR_data = rmmissing(VAR_data)
save var_data VAR_data gs_1 gs_10 gdpdef
%% cay data
% The cay data was downloaded as a csv.  The variable name of c (pce) was modified 
% to just c. 
%%
cay = readtable('cay.csv','HeaderLines',1);
dates = [];
for date = cay.date
    dates=[dates;datetime(floor(date/100), mod(date,100), 1)];
end
cay.date = dates;
cay = table2timetable(cay)
save cay cay