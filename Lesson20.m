subplot(2,1,1);
bar(byCountry.total_cases);

title('Covid Cases by Country');
xlabel('country');
ylabel('number of cases');

xticks(1:210);
xticklabels(byCountry.location);
xtickangle(45);
plot([sort(randn(100,1)) sort(randn(100,1))*1.5])

subplot(2,1,1);
bar(byCountry.total_cases_per_million);

title('Covid Cases by capita');
xlabel('country');
ylabel('number of cases per capita');

xticks(1:210);
xticklabels(byCountry.location);
xtickangle(45); 