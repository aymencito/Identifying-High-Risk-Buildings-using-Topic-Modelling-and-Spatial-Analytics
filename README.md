# Utility Analytics: Natural Language Processing and Spatial Dashboard

The objective of this project is to identify high risk buildings in New York City. A building is determined "high" risk if there is a a higher probability of harm to New York City residents,  due to poor workmanship or illegal activity. Structural topic modelling package in R was used for natural language processing analysis and geocoding,  python was used to clean and code the data, Tableau was used to visualize data.

The project had two steps:
1. Anlaysis of text data using topic modelling and identifying key works that indicate high risk.
2. Creating a spatial dashboard using Tableau.

#Topic Modelling Results

Text data from Con Edison visits were analyzed, topic modelling automatically generates topics from the text. The topics can be broadly categorized as incidents related to boilers, customer complaints of service shut off, gas leaks, gas meter issues, illegal activity and service shut off, failure of integrity tests and unsafe piping. Here are some of the results:

The Topics
Topic 1: Boiler and gas related issues (includes physical harm to residents)
Key Words: boiler, acv, found, plug, spillag, unit, hwh

Topic 4: FDNY called to location, structural damage
Key Words: fdny, fire, locat, shut, due, case, cpms 

Topic 5: Found one or multiple gas leaks, service shut off.
Key Words: leak, found, shut, cpms, case, odor, locat 

Topic 8: Found illegal activity and service shut off
Key Words: servic, valv, shut, locat, head, illeg, hos 

Topic 10: Piping unsafe due to shoddy and/ or unsupported work
Key Words: pipe, tag, hous, left, issu, lock, safe 


#Spatial Dashboard
The dashboard included a map of incidents, 3D satallite image of building and menus to filter the data. A user can click on an incident of interest on the map and an automatic satellite image of the building is produced. Notes of the incident are also created. Below is an image of the dashboard:


