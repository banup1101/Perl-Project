#Brandon Anup BCS 316
#Final Project (Project 2) vgsales

use 5.23.0;

#List of Things I Need To Do:
#Top sales by Platform, Year, Genre and Publisher (all separately).	done
#Top sales by Platform given the year	done
#Top sales by Genre given the year	done
#Top sales by Publisher given the year	done
#Game with the lowest sales done
#Game with the highest sales done
#Platform with the lowest and highest sales done
#Publisher with the lowest and highest sales  done
#Year with highest sales and Year with the lowest sales done

use Term::Menus;
use Term::ANSIColor; #this color stuff does not look like its working in the terminal
use Term::ANSIColor qw(:constants);

#Explanation of code:
#The following code essentially reads the csv file, stores the information in their respected hashes
#and then you use the menu to output whatever you wanted it to
#Things are outputted by going through the for loop to go through hash and then printing out the information
#Some of these later on had to be sorted
#color stuff just didnt work because it turns out some consoles you just can't see the color change for some reason


#open csv 
my $filename = "vgsales.csv";
open(my $file, '<', $filename);
#close($file);

my $header = <$file>;

#hashes
my %gamesales;
my %platformsales;
my %yearsales;
my %genresales;
my %publishersales;

my %platformsalesyear;
my %genresalesyear;
my %publishersalesyear;



#chomp header and store everything in correct variables
while(my $line = <$file>){
	chomp $line;
	
	#the csv file for some reason has ,, after name of the games so i'm assuming having a variable called $empty for this will not cause any problems
	my ($name, $empty, $platform, $genre, $publisher, $sales, $year) = split(',', $line); #for some reason there is a ,, after name in the csv
	#print("$name $publisher \n");
	
	#############Bullet 1#############
	#Game Sales:
	$gamesales{$name} += $sales;
	#print(%gamesales); #prints name of game with the sales following it 
	
	#Platform Sales:
	$platformsales{$platform} += $sales; #Sales by Platform
	
	#Year Sales:
	$yearsales{$year} += $sales; #Sales by year
	
	#Genre Sales:
	$genresales{$genre} += $sales; #Sales my Genre
	
	#Publisher Sales:
	$publishersales{$publisher} += $sales; #Sales by Publisher	
	
	############Bullet 2-4############
	#Platform Sales Given Year:
	$platformsalesyear{"$platform, $year"} += $sales; 
	
	#Genre Sales Given Year:
	$genresalesyear{"$genre, $year"} += $sales; 
	
	#Publisher Sales Given Year:
	$publishersalesyear{"$publisher, $year"} += $sales; 
	
}
close $file;

#my pretty menu
my @menu = ("Top Sales By Platform", "Top Sales By Genre", "Top Sales By Publisher", 
			"Platform Given Year", "Genre Given Year", "Publisher Given Year",
			"Games With The Lowest Sales", "Games With The Highest Sales",
			"Platform With The Lowest Sales", "Platform With The Highest Sales",
			"Publisher With The Lowest Sales", "Publisher With The Highest Sales",
			"Year With The Lowest Sales", "Year With The Highest Sales");
	
my $banner = "Select an Option to Search for";
my $selection = &pick(\@menu, $banner);

#conditions and all the outputs
if($selection eq "Top Sales By Platform"){
		print("\nTop Sales By Platform:\n");
		foreach my $platform(keys %platformsales){ #I don't need to sort this yet since its done later on  sort{$platformsales{$b} <=> $platformsales{$a} } 
			print("$platform: $platformsales{$platform}\n");
	}
}
elsif($selection eq "Top Sales By Genre"){
	print("\nTop Sales By Genre:\n");
		foreach my $genre(keys %genresales){ #sort{$genresales{$b} <=> $genresales{$a} }
			print("$genre: $genresales{$genre}\n");
	}
}
elsif($selection eq "Top Sales By Publisher"){
	print("\nTop Sales By Publisher:\n");
	foreach my $publisher(keys %publishersales){ #sort{$publishersales{$b} <=> $publishersales{$a} }
			print("$publisher: $publishersales{$publisher}\n");
	}	
}
elsif($selection eq "Platform Given Year"){
	#print("\nTop Sales By Platform Given Year:", %platformsalesyear);
	print("\nTop Sales By Platform Given Year:\n");
	foreach my $year(sort{$platformsalesyear{$b} <=> $platformsalesyear{$a} } keys %platformsalesyear){
		print("$year: $platformsalesyear{$year}\n");
	}
}
elsif($selection eq "Genre Given Year"){
	#print("\nTop Sales By Genre Given Year:", %genresalesyear);
	print("\nTop Sales By Genre Given Year:\n");
	foreach my $year(sort{$genresalesyear{$b} <=> $genresalesyear{$a} } keys %genresalesyear){
		print("$year: $genresalesyear{$year}\n");
	}
}
elsif($selection eq "Publisher Given Year"){
	print("\nTop Sales By Publisher Given Year:\n");
		foreach my $year(sort{$publishersalesyear{$b} <=> $publishersalesyear{$a} } keys %publishersalesyear){
		print("$year: $publishersalesyear{$year}\n");
	}
}
elsif($selection eq "Games With The Lowest Sales"){
		print("\nGames With The Lowest Sales:\n");
		foreach my $name(sort{$gamesales{$a} <=> $gamesales{$b} } keys %gamesales){
			print("$name: $gamesales{$name}\n");
		}
}
elsif($selection eq "Games With The Highest Sales"){
		print("\nGames With The Highest Sales:\n");
		foreach my $name(sort{$gamesales{$b} <=> $gamesales{$a} } keys %gamesales){
			print("$name: $gamesales{$name}\n");
		}
}
elsif($selection eq "Platform With The Lowest Sales"){
		print("\nPlatform With The Lowest Sales:\n");
		foreach my $platform(sort{$platformsales{$a} <=> $platformsales{$b} } keys %platformsales){
			print("$platform: $platformsales{$platform}\n");
		}
}
elsif($selection eq "Platform With The Highest Sales"){
		print("\nPlatform With The Highest Sales:\n");
		foreach my $platform(sort{$platformsales{$b} <=> $platformsales{$a} } keys %platformsales){
			print("$platform: $platformsales{$platform}\n");
		}
}
elsif($selection eq "Publisher With The Lowest Sales"){
		print("\Publisher With The Lowest Sales:\n");
		foreach my $publisher(sort{$publishersales{$a} <=> $publishersales{$b} } keys %publishersales){
			print("$publisher: $publishersales{$publisher}\n");
		}
}
elsif($selection eq "Publisher With The Highest Sales"){
		print("\Publisher With The Highest Sales:\n");
		foreach my $publisher(sort{$publishersales{$b} <=> $publishersales{$a} } keys %publishersales){
			print("$publisher: $publishersales{$publisher}\n");
		}
}
elsif($selection eq "Year With The Lowest Sales"){
		print("\Year With The Lowest Sales:\n");
		foreach my $year(sort{$yearsales{$a} <=> $yearsales{$b} } keys %yearsales){
			print("$year: $yearsales{$year}\n");
		}
}
elsif($selection eq "Year With The Highest Sales"){
		print("\Year With The Highest Sales:\n");
		foreach my $year(sort{$yearsales{$b} <=> $yearsales{$a} } keys %yearsales){
			print("$year: $yearsales{$year}\n");
		}
}
