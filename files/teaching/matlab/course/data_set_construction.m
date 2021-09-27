%% Data Set Construction
% This file presents a 100% code method to import data. In practice it is often 
% simpler to use the import wizard (right click on a file in Current Folder, Import 
% Data...) when importing a few files.
%% Notes
% This is a 100% code method to accomplish this task. The data import wizard 
% (right click in Current Folder) is much simpler than doing everything using 
% code.
%% Setup
% Clear and reset the workspace and load required data

% Clean up everything
clear all
close all
clc
%% Index data
% The dates in the csv have been converted to YYYYDDMM using a custom format 
% in Excel (yyyymmdd).

% Skip the first row
SP500 = csvread('SP500.csv',1);
% Data is upside down.  Earliest date should be first.
SP500 = flipud(SP500);
% Convert yyyymmdd to MATLAB date format
SP500_mldate = c2mdate(SP500(:,1));
% Get close price
SP500_close = SP500(:,7);
% Get yyyymmdd dates
SP500_yyyymmdd = SP500(:,1);
% Assemble 
SP500_daily = [SP500_yyyymmdd SP500_mldate SP500_close];

% Repetition of previous code, only for FTSE
FTSE100 = csvread('FTSE100.csv',1);
FTSE100 = flipud(FTSE100);
FTSE100_mldate = c2mdate(FTSE100(:,1));
FTSE100_close = FTSE100(:,7);
FTSE100_yyyymmdd = FTSE100(:,1);
FTSE100_daily = [FTSE100_yyyymmdd FTSE100_mldate FTSE100_close];
%% Weekly aggregation
% Weekly aggregation uses Tuesday closing prices since Tuesdays are likely to 
% be trading days.

% Get earliest and latest date
x = SP500_daily;
min_date = min(x(:,2));
max_date = max(x(:,2));
% List of all dates between earliest and latest
all_dates = min_date:max_date;
% Uses US dates so that Tuesday is 3, Sunday is 1
tuesdays = weekday(all_dates, 'en_US')==3;
tuesdays = all_dates(tuesdays);

% Simple but slow method
weekly_data = zeros(length(tuesdays),3);
for i=1:length(tuesdays)
    % Find last date <= current Tuesday
    loc = find(x(:,2)<=tuesdays(i), 1, 'last' );
    % Store data
    weekly_data(i,:) = x(loc,:);
end
SP500_weekly = weekly_data;

% Repeat for FTSE, a function would be better
x = FTSE100_daily;
min_date = min(x(:,2));
max_date = max(x(:,2));
all_dates = min_date:max_date;
% Assumes US dates so that Tuesday is 3, Sunday is 1
tuesdays = weekday(all_dates)==3;
tuesdays = all_dates(tuesdays);

% Simple but slow method
weekly_data = zeros(length(tuesdays),3);
for i=1:length(tuesdays)
loc = find(x(:,2)<=tuesdays(i), 1, 'last' );
weekly_data(i,:) = x(loc,:);
end
FTSE100_weekly = weekly_data;
%% Monthly aggregation
% This code uses diff and logical indexing to find the locations where the month 
% (number) changes. This is the last day of the month.

% Use diff on day to find last day in month
x = SP500_daily;
dates = x(:,1);
year = floor(dates/10000);
month = floor((dates - 10000*year)/100);
SP500_monthly = x(diff(month)~=0,:);

x = FTSE100_daily;
dates = x(:,1);
year = floor(dates/10000);
month = floor((dates - 10000*year)/100);
FTSE100_monthly = x(diff(month)~=0,:);

% Or write a function 
price = SP500_daily(:,3);
date = SP500_daily(:,1);
[SP500_monthly_price,SP500_monthly_date] = month_end_prices(price,date);

save SP_FTSE *_daily *_weekly *_monthly
%% Fama-French Data
% All files were converted to Excel (xlsx) files. Only the top panel was in 
% both files.

FF_factors_monthly = xlsread('F-F_Research_Data_Factors.xlsx');
FF_factors_daily = xlsread('F-F_Research_Data_Factors_daily.xlsx');

FF_portfolios_monthly = xlsread('25_Portfolios_5x5.xlsx');
FF_portfolios_daily = xlsread('25_Portfolios_5x5_daily.xlsx');
save FF_data FF*
%% Foreign Exchange Rates
% This block shows some advanced features:
% 
% * Cell arrays to hold string data
% * Loops over files names
% * textscan to read data into a cell array
% * str2double to convert strings to numbers
% * eval to rename arrays using string
% 
% It is probably simpler to convert the data to Excel and import the Excel.

files = {'DEXJPUS.txt','DEXUSAL.txt','DEXUSEU.txt','DEXUSUK.txt'};
fxrates = {'JPYUSD','AUDUSD','EURUSD','GBPUSD'};
for i = 1:length(files)
    % Open the file for reading
    fid = fopen(files{i},'rt');
    % Textscan to read dates and values
    data = textscan(fid,'%s %s','ReturnOnError',false);
    % Separate the two
    dates = data{1};
    values = data{2};
    % Initialize a holder using nan, which is easy to remove later
    temp = nan(length(dates),2);
    % Loop over data
    for j=1:length(dates)
        if sum(dates{j}=='-')==2 % date
            % Convert date to yyyymmdd, note skipping - character
            temp(j,1) = str2double(dates{j}([1:4 6:7 9:10]));
            % Convert values
            temp(j,2) = str2double(values{j});
        end
    end
    % Remove any rows with nan
    temp = temp(~any(isnan(temp),2),:);
    temp = [c2mdate(temp(:,1)) temp]; %#ok<AGROW>
    % Rename the variable using a string expression
    eval([fxrates{i} ' = temp;'])
    % Save the data
    save(fxrates{i},fxrates{i})
    % Close the file
    fclose(fid);
end
%% Importing using |readtable|
% |readtable| is a more modern method to read data.  Rather than import a numeric 
% matrix, it can handle mixed data and will attempt to assign series-appropriate 
% data types to each column.  We can repeat the import of the S&P 500 using readtable 
% to see the differences.

SP500_table = readtable('SP500.csv')
SP500_table.Properties
%% 
% Reading in the data to a table reads variables names (and corrects ones 
% which are not valid MATLAB variable names).  The Properties attribute provides 
% some information about the table. 
% 
% Variables can be accessed using dot notation and the variable name.  

disp('Dot access')
SP500_table.Open
%% 
% The familiar slice notation is also usable with tables

disp('Slice')
SP500_table(1:5,1:3)
%% 
% Data can be saved in the same manner.

save SP500_table SP500_table
%% 
% Finally, tables can be converted to matrices using table2array

SP500_mat = table2array(SP500_table)
SP500_mat(1:5,1:3)
%% Reading in formatted dates
% |readtable| can import formatted dates such as 1990-01-01 from Excel or CSV.  
% This will produce a table with the dates as strings.  These can be converted 
% into datetimes using the function datetime. This avoids much of the pain of 
% working with either MATLAB dates of numeric dates of the form YYYYMMDD.
% 
% Note the difference in the tables -- the string version has '2013-10-25' 
% while the datetime version has just 2013-10-25.  One can use |isdatetime| to 
% test if a column is in datetime format. 

SP500_table = readtable('SP500_excel_dates.xlsx')
disp('Before')
isdatetime(SP500_table.Date)
SP500_table.Date = datetime(SP500_table.Date)
disp('After')
isdatetime(SP500_table.Date)
%% 
%