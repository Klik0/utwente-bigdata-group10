# UTwente Big Data Group 10
This source repository contains the code for the Big Data course project for the University of Twente by group 10.

The University of Twente has received 66.5 million tweets about the World Cup 2014, one of the biggest sports events in the world.

We will analyse the Twitter user activity based on the time and country of origin of the users. We will detect peaks in activity of these users from various countries and relate these peaks to events from World Cup 2014. We will try to prove or disprove that an increased activity from users of certain countries can be monitored when their country is playing a match or see if some other important event is taking place at that time.

The analysis of the tweets is performed by a large machine cluster owned by the University of Twente. 

> This repository does not contain any tweet data, we only provide a framework to handle the Twitter data!

# Implementation
The implementation is done using an Apache Pig script (i.e. script.pig). The provided data is stored on 667 seperate txt files and formatted in JSON format, which can be read by the Elephant Bird JSON loader.

The data is grouped by country and time periods. The time periods consist of 10 minute chunks. The countries are detected using geo location data (latitude, longitude) if available or twitter's language detection.

The amount of tweets per group are counted. The final output is stored in seperate files. One for each country. This should make it easier to analyse the results.

In our research paper we analyse the results.

# Installation
## Required software
The following software needs to be installed on the machine:
* Apache Pig
* Elephant Bird

## Dependencies
The following libraries are used by the Pig script:
* hadoop.jar (for Elephant Bird)
* pig.jar (for Elephant Bird)
* json_simple-1.1.jar (for Elephant Bird)
* udfs.jar (custom User Defined Function for Country Detection)
* piggybank-0.12.0-chd5.2.1.jar (for storing in multiple files)

# Execution
> *Warning!*
> The script points to the location of the data on our system (i.e '/user/alyr/worldcup/part*.txt'), you will have to alter this to point to the location of the data on your system.
> In addition, the data must be on the Hadoop file system before execution!

The script can be executed using the following command:
```
pig script.pig
```

# Contributors
Cristian Ciobotea, Nico Korthout and Martin Myslík

# License
The MIT License (MIT)

Copyright (c) 2015 University of Twente

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.