function [month_end_price, month_end_date] = month_end_prices(price,date)
% Returns month end prices
%
% date is yyyymmdd
%
% Example:
% [month_end_price, month_end_date] = month_end_prices(price,date)



year = floor(date/10000);
month = floor((date - 10000*year)/100);
loc =diff(month)~=0;
month_end_price = price(loc);
month_end_date = date(loc);
