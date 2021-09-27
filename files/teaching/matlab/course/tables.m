%% Tables
% Tables are the modern way to hold data in MATLAB.  They have labels that are 
% meaningful unlike simple arrays which require the user to remember which column 
% is which. 
% 
% 
% 
% Start by clearing and loading the data file we saved earlier.
%%
clear all;
load stock-prices
%% 
% First, we use |table| to buid a table with the arrays.  The names are 
% inferred from the variable names.
%%
tab = table(SPY, AAPL, GOOG)
%% 
% Next we build an array of |datetime| to use as the index.  These dates 
% are in the introduction document. 
% 
% _Note_: This is not a good way to good way to build an array (concatenation) 
% but is simple for small arrays.
%%
dates = []
for i = [4,5,6,7,10,11,12,13,14,17,18,19]
    dates = [dates;datetime(2018,9,i)];
end
%% |timetable|
% |Here we use timetable to build  a table from the arrays and the dates.|
%%
price_table = timetable(SPY,AAPL,GOOG,'RowTimes',dates)
%% Selecting
% There are multiple ways to select from a table.  The most natural uses the 
% variable names or the row labels to select.  First, we use the variable names 
% to select single columns.  These columns are also tables.  They can be converted 
% to arrays using |table2array.|
%%
aapl = price_table(:,'AAPL')

aapl_array = table2array(price_table(:,'AAPL'))
%% 
% Row labels can also be used to select elements by rows.  Here we use the 
% dates array to provide the labels to select.
%%
rows = price_table(dates(1:7),:)
%% 
% Using . selectors with the variable name directly pull out the array
%%
aapl_array2 = price_table.AAPL
%% Converting
% A table with a column of dates can be upgraded to a timetable using |table2timetable.|
%%
table_with_dates = table(dates,SPY, AAPL, GOOG)
tt = table2timetable(table_with_dates)