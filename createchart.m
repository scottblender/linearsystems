function temperature_chart = createchart(values)
%------------------------------
%| temperature_chart = createchart(values)
%| produces a matrix of specified values 
%| values are the input temperatures to convert in order of [temp in C,
%temp in F, temp in R, temp in K].
%| temperatue_chart returned is the resulting matrix after perfoming the
%conversions.
temperature_chart = zeros(length(values));
string_values = ["c", "f", "r", "k"];
for jj=1:length(values)
    temperature_chart(jj,:) = Tconvert2(values(jj), string_values(jj));
end
