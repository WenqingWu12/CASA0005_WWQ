#stpe1 packages
install.packages("countrycode")
library(countrycode)
library(sf)
library(here)
library(janitor)
library(tidyverse)
library(terra)
library(ggplot2)
library(RSQLite)
library(countrycode)

#step2 data
HDI <- read_csv(here::here("E:/CASA0005/prac4/home4/home4_data/HDR21-22_Composite_indices_complete_time_series.csv"),
                locale = locale(encoding = "latin1"),
                na = " ", skip=0)
World <- st_read("E:/CASA0005/prac4/home4/home4_data/World_Countries__Generalized_.shp")

#Step3 change country name to country code by using function'countrycode'
HDIcols<- HDI %>%
  clean_names()%>%
  select(iso3, country, gii_2019, gii_2010)%>%
  mutate(difference=gii_2019 - gii_2010)%>%
  mutate(iso_code=countrycode(country, origin = 'country.name', destination = 'iso2c'))%>%
  mutate(iso_code2=countrycode(iso3, origin ='iso3c', destination = 'iso2c'))

#step4 join data
Join_HDI <- World %>% 
  clean_names() %>%
  left_join(., 
            HDIcols,
            by = c("iso" = "iso_code"))