# Calendar Lite
Simple calendar app showing Calendar and agenda showing your daily events.

## Features:
1. Shows calendar for the whole year. 
2. Shows events for selected day in calendar
3. Shows Calendar only view
4. Shows Agenda only view
5. When you scroll through events it scrolls through calendar to select the correct date
6. If you select a day with no events in calendar it shows "No events" in agenda
7. When viewing Calendar if you select a day it brings up agenda for that day.
8. Events can be added using Events.json file or programatically using examples in EventService class.
9. The app has a bonus feature of getting weather at current location of the device. This can be viewed by tapping on Weather Tab. Please note that it shows raw weather data retrieved from the API.
10. App has limited UI test cases defined. The test cases in YearGrid_Tests are key to checking if the calendar has been layed out accurately. 


## Note:
1. For simplicity the app shows only current year. The app can easily be extended to show previous and future years.
2. I have not implemented + button to define new calendar events due to limitation of time. This can be done very easily by adding date picker form
3. I have tested the app in portrait mode only
4. More UI tests must be added for better code coverage
5. Current Weather can be integrated with Main calender tab in multiple ways. For example, 
   i. by showing a weather button in Navigation bar with current local temprature as button title
   ii. Providing a button next to event in Agenda to retrive forecasted or timeseries weather information at location of the the event.


