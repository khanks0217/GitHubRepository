Kris Hanks

Scientific Computation Final Project, Fall 2022

*Project Description*

To simulate the spread of an infectious disease, I developed a compartmental model that continually updates a description of all the people in a population and tracks their status–susceptible, recovered, vaccinated, and sick. This simulation always begins with one person being infected and assumes that the population is constant such that births and deaths are ignored; the program then tracks the population each day and runs until none of the population is sick.


*Running the Program*

Upon running the program, the user is asked for four variables: 

	- population size, (Pop. Austin, TX = 964177)
	- probability of disease transmission
	- percent of the population that is vaccinated
	- number of days to recover. 

To Compile:

	g++ -std=c++17 SIRModel.cpp

To Run:

	./a.out

*Expected Output*

The majority of the program output displays the number of days since the first infection, the number infected, recovered, and susceptible each separated by a comma. The last output line contains the maximum number of infected, recovered, and susceptible individuals. After running a series of models using different populations, trasmission rate, and vaccination rates I graphed the data in Excel.


*Areas for Improvement*

The program calculates the number of citizens that are vaccinated as a constant–having a constant number of vaccinated citizens is unrealistic because the rate of vaccination, and therefore the number of vaccinated people, increases in response to the spread of an illness.
