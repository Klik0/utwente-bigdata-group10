REGISTER 'lib/hadoop.jar'; 
REGISTER 'lib/pig.jar'; 
REGISTER 'lib/json_simple-1.1.jar';
REGISTER 'lib/udfs.jar'
REGISTER 'lib/piggybank-0.12.0-cdh5.2.1.jar';

loadedData = LOAD '/user/alyr/worldcup/part*.txt' 
	USING com.twitter.elephantbird.pig.load.JsonLoader('-nestedLoad') AS myInput; 

userPeriods = FOREACH loadedData GENERATE 
	myInput#'user' AS User, 
	SUBSTRING(myInput#'created_at',0,15) AS periods,
	myInput#'coordinates' as coordinates;

langPeriodsCoord1 = FOREACH userPeriods GENERATE 
	User#'lang' AS lang, 
	periods,
	coordinates#'coordinates' as coordinatesBag:bag{t1:tuple(f1:float, f2:float)};

langPeriodsCoord2 = FOREACH langPeriodsCoord1 GENERATE
	lang,
	periods,
	org.apache.pig.builtin.BagToTuple(coordinatesBag) as coordinatesTuple;

countryPeriods = FOREACH langPeriodsCoord2 GENERATE
	udfs.GetCountry(coordinatesTuple.$0, coordinatesTuple.$1, lang) as country,
	periods;

groups = GROUP countryPeriods 
	BY (country, periods);

countGroups1 = FOREACH groups GENERATE 
	group, 
	COUNT(countryPeriods.periods);

countGroups2 = FOREACH countGroups1 GENERATE 
	FLATTEN($0), 
	$1;

orderedCountGroups = ORDER countGroups2 
	BY $1 DESC;

STORE orderedCountGroups INTO 'finaloutput' 
	USING org.apache.pig.piggybank.storage.MultiStorage('finaloutput', '0', 'none', ',');
