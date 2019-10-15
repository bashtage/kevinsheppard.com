%% Accessing Elements in Matrices and Tables
%% Clear the workspace
% Clear any existing variables
%%
clear all
close all
clc
%% Initial setup
% These matrices will be used in the exercises
%%
clear /*all*/
 x=1:25;  
 x=reshape(x,5,5)
 y = 1:5
 z = (1:5)'
%% Select element 11
% Matrices in MATLAB use row major which means elements are adjacent in member 
% across rows but not columns. This means that the upper left is element 1, the 
% element to its right is element 2, and so on until the first row is exhausted, 
% and then element k+1 is in row 2, column 1 where k is the number of columns 
% in the matrix.
%%
x(11)
%% Selecting using 2 indices
% Usually two indices are used for matrices that have dimensions larger than 
% 1 in both axes. Selection uses parenthesis and is |(row, column)|.\
%%
x(1,3) % row 1, column 3
x(3,1) % row 3, column 1
%% Selecting rows and columns
% Entire rows or columns can be selected using the colon : operator. This is 
% simply interpreted as 'all'
%%
% Row 2
x(2,:)
z(2,:) 
% y(2,:) % error, row 2!
% Column 2
x(:,2)
%% Selecting using the color operator (slicing)
% The slice operator allows elements to be selected in a range. The most common 
% uses |start:end| which selects all elements between |start| and  |end|, inclusive. 
% Elements can also be selected using the numeric index in a basic array, as in 
% the second example. 
%%
% Columns 2 and 3
x(:,2:3)
% Columns 2 and 3, but only rows 2 and 4
x([2, 4],2:3)
%% Table setup
% Tables are usually constructed when reading in data using |readtable|. However 
% they can also be constructed using the function |table|. These examples create 
% a basic table, the same table but with custom variable names, and a table containing 
% mixed data types. 
%%
t1 = table(x(:,1), x(:,2), x(:,3), x(:,4), x(:,5));
t2 = table(x(:,1), x(:,2), x(:,3), x(:,4), x(:,5), ...
           'VariableNames',{'Alpha','Beta','Delta','Gamma','Epsilon'});
nums = [3.14,2.71,1.61]'; % Name sure column
dates = datetime({'1990-01-01','2000-01-01','2010-01-01'})';
strings = {'Wilson Phillips','Faith Hill','KeSha'}';
t3 = table(nums, dates, strings, 'VariableNames', {'number','date','str'});
disp('t1')
t1
disp('t2')
t2
disp('t3')
t3
%% Selecting elements from a table
% Table element selection is similar to matrix element selection except that 
% there are two ways to select elements. The first uses parentheses () and returns 
% a _table_. When selecting a table a raw number is usually desired and so elements 
% can be selected using braces as well {}. Braces always return an array, _not 
% a table_, and so when selecting a single elements, a scalar is returned.
%%
% Return single element tables -- probably not what would be wanted
t1(3,2)
t2(3,2)
t3(3,2)
 
% Return plain scalars
t1{3,2}
t2{3,2}
t3{3,2}
%% Selecting columns from a table
% Column selection is also virtually identical with the same exception -- either 
% parentheses () or braces {} can be used. Using parentheses will return a table 
% with a single column. Using braces will return a column vector.
%%
% Return single column table
t1(:,2)
t2(:,2)
t3(:,2)
 
% Returns a plain array
t1{:,2}
t2{:,2}
t3{:,2}
%% Selecting tables form a table
% Since using parentheses will return a table, selecting a table from a table 
% is simple. Braces {} can also be used to select blocks from a table with one 
% important caveat -- all columns *must* have the same data types (e.g., all numeric).
%%
% Return subtable of the original table
t1(:,[1 3])
t2(:,[1 3])
t3(:,[1 3])
 
% Returns a plain array
t1{:,[1 3]}
t2{:,[1 3]}
% Produces an error
% t3{:,[1 3]}