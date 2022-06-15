# How to run project
- Clone or download the project to your computer
- Once you have the folder, open it with android studios
- Choose your device and then run the project.

# Request explained
My GET request: https://api.football-data.org/v4/competitions/PL/matches?dateFrom=2022-04-22&dateTo=2022-05-22&status=FINISHED

- I decided to go with the Premier League
- I chose dates **April 22 - May 22** because the league ended on **May 22** as stated on the full coverage of the premier league on the api's website
  - Full coverage of the premier league URL: https://native-stats.org/competition/PL/2021
- I decided to only request for matches with status **FINISHED** to avoid getting rescheduled or cancelled matches.

# Project structure
 - The project has 2 main folder **Service & Screens**
 - The **Service** folder contains the **ApiService**. This is where all the interactions with the api are done.
 - The **Screens** folder contains the main screen of the app that displays the winning team
