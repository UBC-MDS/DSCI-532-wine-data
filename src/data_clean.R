# load data
wine <- read.csv("wine_1.csv")
head(wine)

# dropping the region_2 columns 
wine <- wine %>% 
  select(-c(region_2))

#removing 'na' values from the data
wine <- wine %>% 
  na.omit(wine)

#continent-country mapping for map representation and filter adjustment
#source of mapping file : 
country_continent <- as.data.frame(read.csv("Countries-Continents.csv"))
#unique(country_continent$Country)
#unique(wine$country)

country_continent <- country_continent %>% 
  select(c(Country, Continent))

colnames(country_continent) <- c("country", "continent")
wine_data <- left_join(wine, country_continent, by = "country")
wine_data$continent <- as.character(wine_data$continent)

# we see that the US and England are not getting populated with continents
wine_data <- wine_data %>% 
  mutate(continent = if_else(country == "US", true = "North America", false = continent))
wine_data <- wine_data %>% 
  mutate(continent = if_else(country == "England", true = "Europe", false = continent))

#adding the type of wine(red/white) to the data
wine_type <- read.csv("grape_varieties.csv")
wine_data <- left_join(wine_data, wine_type, by = "variety")


#write clean data to a csv
write_csv(wine_data, "clean_wine_data.csv")

