clear 
close all
clc

myMeans = [18 15 15 16];
for condition = 1:4
    for participant=1:16
        data(participant, condition)  = myMeans(condition) + randn*3;
    end 
end

% one samaple t-test
[h p]  = ttest(data(:,2),data(:,4));
% first value: is the null hypothesis true (1) or false (0)?
% second value is the p-value

bar(mean(data));

% .csv files are the most common type of storage for scientific data
% or .xls or .tsv

% there are multiple ways  to  improt data
% esay  way: drag your data file from a folder directily into Matlab
% workspace
% REading in data:
MeteoriteLandings = readtable('Meteorite_Landings.csv');
MeteoriteLandings(10,{'name','year'});

% Extracting data from a table
% {} to extract data
% () will give you a new table

% Finding specific data in a table
% Eg. we only want to know about meteorites that were witnessed
fellInd = find(MeteoriteLandings.fall,'Fell');
% nb - in new versions of matlab you don't have to use strcmp with tables
FellMets=MeteoriteLandings(fellInd,:);

%% Exercises 
%% --- ex 1 --- %%
%sort the table so the biggest meteorites are at the top
%Use this rank indexing to make a new table which contains (only) %the 10 biggest meteors.
%Draw a bar plot of this.

MeteoriteLandings = readtable('Meteorite_Landings.csv');
NewTable = sortrows(MeteoriteLandings, 'mass_g_', 'descend');
NewTable = NewTable(1:10,:);

figure;
bar(NewTable.mass_g_);

%% --- ex 2 --- %%
% use the function ‘scatter’ to draw the x y plot of ALL the meteors 
%Can you notice anything about how meteorites hit the earth?
% use ‘hold on’ to allow additive plotting
% use the function ‘text’ to superimpose the names of the biggest 10 meteorites on the plot
figure;
scatter(MeteoriteLandings.reclong,MeteoriteLandings.reclat);
hold on
text(NewTable.reclong,NewTable.reclat,NewTable.name);

hold off

%% --- ex 3 --- %%
%Use an index to find all the rows where the meteorites are classed as ‘Howardite’ 
%Use this to make a new table
%Now do the same to make a table with all the meteorites classed as iron.
%Do a two sample ttest (‘ttest2’) to see if ‘Iron’ meteors are heavier than Howardite’s. 
%Can you draw a bar plot (you will need to concatinate the two means).
HowarditeInd = find(strcmp('Howardite',MeteoriteLandings.recclass));
HowarditeTable = MeteoriteLandings(HowarditeInd,:);
[h p] = ttest2(HowarditeTable.mass_g_,IronTable.mass_g_);
figure;
bar([mean(HowarditeTable.mass_g_), mean(IronTable.mass_g_)]);

%% --- ex 4 --- %%
%Repeat execercise 2 using the function geoscatter  
figure;
geoscatter(MeteoriteLandings.reclat,MeteoriteLandings.reclong);
hold on
text(NewTable.reclat, NewTable.reclong, NewTable.name);