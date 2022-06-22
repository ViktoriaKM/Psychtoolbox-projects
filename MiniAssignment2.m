% Part  1 

clear all 
close all
clc
%     read in data owid-covid-data.csv
CovidTable = readtable('owid-covid-data.csv');




%     pick two countries
% Let's  choose Sweden and USA
% First we need to find their indeces in the table
SweInd = (strcmp(CovidTable.location,'Sweden'));
USAInd = (strcmp(CovidTable.location, 'United States'));
% create separate table for each country
SweTable = CovidTable(SweInd,:);
USATable = CovidTable(USAInd,:);
%% 

%for this section: use subplot, label axes and
%give the plot a title 
%over time for each country, plot the:

% a) total number of cases over time for each country. 
figure;
title('Total number of Covid Cases for Sweden and USA')

subplot(2,1,1); 
xlabel('Sweden');
ylabel('Number of cases');
hold on;
bar(SweTable.total_cases);

subplot(2,1,2);
bar(USATable.total_cases);
xlabel('USA');
ylabel('Number of Cases');
%%  b) the total number of cases for each country per capita 
figure;
title('Total number of Covid Cases per Capita for Sweden and USA')

subplot(2,1,1); 
xlabel('Sweden');
ylabel('Number of cases per capita');
hold on;
bar(SweTable.total_cases_per_million);

subplot(2,1,2);
bar(USATable.total_cases_per_million);
xlabel('USA');
ylabel('Number of cases per capita');
%%  c) the total number of *new* cases for each country per capita

figure;
title('Total number of new Covid Cases per Capita for Sweden and USA')

subplot(2,1,1); 
xlabel('Sweden');
ylabel('Number of new cases per capita');
hold on;
bar(SweTable.new_cases_per_million);

subplot(2,1,2);
bar(USATable.new_cases_per_million);
xlabel('USA');
ylabel('Number of new cases per capita');
%% d) the total number of new *weekly* cases for each country per capita.


TotSweWeeklyCases = zeros(23,1);
weeklyInd = [1:7:161-2*7];
for week = weeklyInd 
    SweWeek = SweTable(week:week+7, {'date', 'new_cases_per_million'});
    SweWeeklyCases = sum(SweWeek.new_cases_per_million)/7;
    TotSweWeeklyCases(week) = SweWeeklyCases;
end
AvgSweWeeklyCases = sum(TotSweWeeklyCases)/7;
disp(['The toatl average number of weekly cases per capita for Sweden is ', num2str(round(AvgSweWeeklyCases))]);

TotUSAWeeklyCases = zeros(23,1);
weeklyInd = [1:7:161-2*7];
for week = weeklyInd 
    USAWeek = USATable(week:week+7, {'date', 'new_cases_per_million'});
    USAWeeklyCases = sum(USAWeek.new_cases_per_million)/7;
    TotUSAWeeklyCases(week) = USAWeeklyCases;
end
AvgUSAWeeklyCases = sum(TotUSAWeeklyCases)/7;
disp(['The toatl average number of weekly cases per capita for USA is ', num2str(round(AvgUSAWeeklyCases))]);
%%  Part 2 Use this code to get recent results for each country
% Changed to the most recent date availible from the table
x=datetime(2020,06,01);
ind=find(CovidTable.date==x);
byCountry=CovidTable(ind,:);
%     now plot proportion of deaths per capita as a  function of total
%     cases (use axis labels and plots % per capita



totCasesByCountry = byCountry.total_cases_per_million;
perCapitaDeaths = byCountry.total_deaths_per_million;
proportions = perCapitaDeaths./totCasesByCountry;
plot(totCasesByCountry,proportions);
xlabel('total cases per capita by country');
ylabel('% of deaths from total cases');
% propotrionDeaths = perCapitaDeaths./totCasesByCountry;
%     use 'text' to display the name of each country
%countryNames = byCountry(ind,byCountry.location);
%text(totCasesByCountry,perCapitaDeaths, countryNames);
%     pick two other variables from the table and investigate and plot the result
%     (only really makes sense for 'total' rather than 'new' variables)
%      