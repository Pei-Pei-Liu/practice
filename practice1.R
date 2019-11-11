# Load libraries
library(plotly)
library(tidyverse)
library(gapminder)
library(nycflights13)


# Load gapminder data
data <- gapminder


# links data to ggplot, but will be an empty plot
data %>% 
  ggplot()

# next layer
data %>% 
  ggplot(aes(x = gdpPercap, y = lifeExp))

# Basic scatter plot
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point()

# Adjust the alpha to see overlap
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point(alpha = 1/10)
#alpha is an aestheric component but it's only applied to the geometry (not to the data as a whole--the latter example is below)

# Flip axes easily with 'coord_flip()'
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  coord_flip()

# Adjust the x axis scale
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp)) +
  geom_point() +
  scale_x_log10()

# Map population to a size aesthetic (applied to the data as a whole)
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop)) +
  geom_point() +
  scale_x_log10()

# Map continent to size aesthetic
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10()

#remove gridlines (other theme options, can search in RStudio)
data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10() +
  theme_classic()

# Facet data by year - "facet" = "separate by"
plot <-  data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent)) +
  geom_point() +
  scale_x_log10() +
  facet_wrap(~year) +
  theme_classic()

plot

# Easily add titles and label axes
plot + 
  labs(title = "Life Expectancy vs. GDP per Capita\n",
       x = "GDP per Capita",
       y = "Average Life Expectancy")



# Make plot interactive by mapping year to frame aesthetic 
p1 <- data %>%
  ggplot(aes(x = gdpPercap, y = lifeExp, size = pop, color = continent, frame = year)) +
  geom_point(aes(text = paste ("country:",country))) + #add country 'text"
  scale_x_log10() +
  labs(title = "Life Expectancy vs. GDP per Capita\n",
       x = "GDP per Capita",
       y = "Average Life Expectancy")
#getting an error on the text aesthetics in this code, so couldn't run any of the remaining code for this plot--it does label the dot with country in the interactive version
#?geom_point and look at documentation
#ggplot doesn't have the ability to map the text on the point--the code is only here so that it will run in ggplotly, and also it's just changing the label from the dataset - all the other info already shows up in plotly when you hover over dots

p1

# Saving plots
ggsave(plot = p1, "gapminder.png", dpi = 600,
       height = 5, width = 7, units = "in")

# Use ggplotly to make it interactive
ggplotly(p1)
# it will "play" and move by year along the sliding bar

#Pretending to add new code
#Here I'm adding another line again
#And another?