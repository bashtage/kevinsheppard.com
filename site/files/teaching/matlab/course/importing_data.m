%% Importing Data
% This covers the problems and exercises in the Importing Data section of the 
% introduction. 
%% Import Wizard
% The import wizard can be launched by right clicking on the file to be imported 
% and then selecting Import Data...
%% Read into a table
% Read table can handle mixed excel files and so there is no need to convert 
% the raw data
%%
data = readtable('excel.xlsx');
% Convert the DATE column to be a datetime
data.DATE = datetime(data.DATE);
%% Format and Import
% Importing into a numeric array works best when the data is all numeric. The 
% excel file was formatted by changing the format of the dates to be numbers so 
% that it can be easily imported. The final line converts the imported dates from 
% Excel dates which start from Jan 1, 1990 to MALTAB dates which start on Jan 
% 1 in the year 0 (See |datestr|_(1)_).
%%
excel_data = xlsread('excel_for_import.xlsx');
excel_dates = x2mdate(excel_data(:,1));
%% Reading in CSV
% MATLAB doesn't like texxt in csv files, so here the first row is skipped.
%%
csv_data = csvread('excel_for_import.csv', 1);
csv_dates = x2mdate(csv_data(:,1));
%% Save data
% Data can be saved using the command _save_ followed by the file name to use 
% when saving and then a list of any variables to be saved. The list of variables 
% can include wildcards by using the * character.
%%
save excel_imported csv_data excel_data csv_dates excel_dates
% Wildcard
save excel_imported_wildcard *_data *_dates
%% Import SPY from Google
% The data was downloaded to a file names spy.csv. This was transformed so that 
% it could be easily imported into a numeric array in the file spy_for_import.csv. 
% The date column is converted using |x2mdate|.
%%
spy = readtable('spy.csv');
spy.Date = datetime(spy.x___Date);

csv_spy = csvread('spy_for_import.csv', 1);
spy_date = x2mdate(csv_spy(:,1));