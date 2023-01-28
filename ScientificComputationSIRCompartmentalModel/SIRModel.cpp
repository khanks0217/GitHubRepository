/*
 * Kris Hanks
 * KH39363
 * Final Project - Chapter 50
 * 	ALWAYS: start with 1 person sick
 * 	Program track day to day infected population
 * 	Run indefinitely until none of the population is sick
 */

#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>
#include <array>
using std::cin;
using std::cout;
using std::endl;
using std::string;
using std::to_string;
using std::vector;
using namespace std;

class Person {
private:
	int state = 0;
	bool infected = false;
public:
//Returns description of person's state (recommended return as a string)
	string status_string(){
		if(state > 0){
			//Return string: sick (sdl to go)
			auto s = "sick (" + to_string(state) + " to go)";
			return s;
		}
		if (state == 0 && infected == false)
			return "susceptible";
		if (state == 0 && infected == true)
			return "recovered";
		if (state == -2)
			return "vaccinated";
	return "Mistakes were made. status_string\n"; 
	}
//Update the person's status to the next day
	void update_person(){
		//Only need to update if they are infected or vaccinated
		//If they have been infected and have no sdl left, update: recovered
		if (state == 0 && infected == true)
			state = -1; 
		//If they have been infected and do have sdl left, update: sdl
		if( state > 0 && infected == true){
			state --;
		}
	return;
	}
//Infect a person with the disease to run for n days
	void infect(int n){
		if(state == 0 && infected == false){
			state = n;
			infected = true;
		}
	return;
	}
//Return a bool indicating whether the person has been sick and is recovered
	bool is_stable(){
		//Person is infected
		if (state > 0 ) 
			return false;
		//Healthy, not infected
		if(state == 0 && infected == false)
			return false;
		//Recovered or Vaccinated
		if( state <= 0 )
			return true;
		cout << "Mistakes were made." << status_string() << endl;
		return false;
	}
	int current_state(){
		return state;
	}
	void vaccinateperson(){
		state = -2;
	}
};

//Population class - vector of Person objects
class Population{
private:
	//Population as a vector consisting of Person objects.
	vector<Person> pop;
	int people = 0; //Number of people in a population
	float probability_of_transmission = 0; //Chance of transmission on contact
	bool spreading = false; 
	int recovery = 0; //How many days to recover from infection.
public:
//Constructor takes number of people.
	int population(int npeople){
		people = npeople;
		pop.resize(people);
		return people;
	}
	void vaccinatepop(float percent){
		int numvax = percent * people;
		srand((unsigned) time(NULL));
		int rando = 0;
		for (int c = 1; c <= numvax; c++){
			rando = 1 + (rand() % (people));
			//If rando has already been vaccinated, find a new person
			if(pop[rando].current_state() == -2){
				c--; 
			}else{
				pop[rando].vaccinateperson();
			}
		}
	}
//Direct neighbours of an infected person can get infected.
	void set_probability_of_transfer(float rando, float bad_luck){
		if(bad_luck <= probability_of_transmission){
			pop[rando].infect(recovery);
		}
	//	cout << "Infection Avoided." << endl ;
	return;
	}

//Method for people interacting
	void interact(int interactions){
		for(int i = 1; i <= interactions; i++){
			float bad_luck = (float) rand() / (float) RAND_MAX;
			int rando = 1 + (rand() % (people + 1));
			set_probability_of_transfer(rando, bad_luck);
		}
	} 
//Method that infects the first random person
	void random_infection(int rand, float transmission, int recover){
			probability_of_transmission = transmission;
			recovery = recover;
			spreading = true;
			pop[rand].infect(recover);
	return;
	}
//Updates all persons in the population. Loop until no people are infected
//Return an array counts[#infected, #recovered, #sick, maxinfected]
//I commented out the display method. 
	std :: array <int,4>  updatecount(){
		std::array<int,4> counts = {0,0,0,0};
		int i = 1;
		//Max number of infected people = counts[3]
		counts[3] = 0;
		while(i <= people){
			switch(pop[i].current_state()){
				case -2: //Vaccinated
					//cout << " V " ;
					pop[i].update_person();
					break;
				case -1: //Recovered
					//cout << " R ";
					counts[1] += 1; //Count Recovered
					pop[i].update_person();
					break;
				case 0: //Healthy
					//cout << " ? ";
					counts[2] += 1; //Count Succeptible
					pop[i].update_person();
					break;
				default: //Sick
					//cout << " " << pop[i].current_state() << " ";
					counts[0] += 1; //Count Infected
					if (counts[0] >= counts[3]){
						counts[3] = counts[0];
					}
					if(pop[i].current_state() != recovery){
						interact(6);
					}
					pop[i].update_person();					
			}
		i++;
		}
	return counts;
	}
bool spread(){
	if( spreading == true)
		return true;
	return false;
}

int currentstate(int person){
	return pop[person].current_state();
}

};

int main(){
//Main methods serve to infect a person, count number of days, and update population.
	int citizens = 0;
	float transmission;
	float pvax;
	int recovery_time;

	cout << "How big is your Population?" << endl;
	cin >> citizens;	
	cout << "Probability of disease transmission (0 <= p <= 1)? " << endl;
	cin >> transmission;
	cout << "Percent of population vaccinated (0 <= v <= 1)? " << endl;
	cin >> pvax;
	cout << "How many days to recover?" << endl;
        cin >> recovery_time;
	if ( transmission <= 0 || transmission >= 1 || pvax <0 || pvax >= 1 || citizens <0 ){
		cout << "Invalid probability of transmission, vaccination, number of citizens, or recovery time." << endl;
		citizens = 0;
	}
	//Declare a vector consisting of Person objects. 
		Population krisville;
		krisville.population(citizens);
	//Vaccinate the population before infecting
		krisville.vaccinatepop(pvax);
	//Infect the first person randomly who is NOT vaccinated!
		srand((unsigned) time(NULL));
                int ran =0;
        	//Find a random person who is not vaccinated. 
	        do {
			ran =  1 +  (rand() % (citizens + 1));	
		}while(krisville.currentstate(ran) == -2);
		krisville.random_infection(ran, transmission, recovery_time); 
	cout << "Number of Citizens Vaccinated: " << (citizens * pvax) << endl;

	int step = 1;
	int maxinfect = 0;
	int maxrecover = 0;
	int maxsucceptible = 0;
	cout << "(Population, Transmission Rate, Percent Vaccinated):" << citizens << "," << transmission << "," << pvax << endl;
	std::array<int, 4> counter;
	cout << "(Days, # Infected, # Recovered, # Succeptible): " << endl;
	for(; ; step++){
		if(citizens == 0) break;	
		//Update population each "day." Count how many are infected, Recovered, Succeptible
		counter = krisville.updatecount();
		cout << step << "," << counter[0] << ", " << counter[1] << ", " << counter[2] << endl;
		if(counter[0] >= maxinfect)
			maxinfect = counter[0];
		if(counter[1] >= maxrecover)
			maxrecover = counter[1];
		if(counter[2] >= maxsucceptible)
			maxsucceptible = counter[2];
		if(counter[0] == 0 && krisville.spread() == true)
			break;
		
	}
	cout << "Disease ran its course by step " << step << endl;
	cout << "Step, Max (Infected, Recovered, Succeptible) : " << step << ", " << maxinfect << ", " << maxrecover << ", " << maxsucceptible << endl;
}
