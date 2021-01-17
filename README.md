# chinchet
This package provides `geom_pushpin`, a geom for adding pushpins to ggplot2


# Installation

The package is available on GitHub. Use the following commands to isntall it:

``` r
# install.packages("devtools")
devtools::install_github("R-CoderDotCom/chinchet")
```

# Usage

`geom_pushpin` works the same way as `geom_point`, but there is an additional argument named `pushpin` which allows you to select the color of the pushpin. Available option are `"red"` (default), `"blue"`, `"green"`, `"yellow"`, `"orange"`, `"gray"`, `"white"` and `"transparent"`.

As the pushpins are PNG files, the `colour` argument is only useful for adding legends.

Note that the represented points are approximately where the pin point is.


## Example 1

```r
# install.packages("ggplot2")
library(ggplot2)

set.seed(1)
data <- data.frame(x = rnorm(100), y = rnorm(100, 20))

ggplot(data, aes(x, y)) +
  geom_pushpin(pushpin = "blue")
```


<p align="center">
 <img src="https://user-images.githubusercontent.com/67192157/104848159-fcfa1380-58e3-11eb-880d-0ae25eb6b4be.png">
</p>


## Example 2

```r
# install.packages("ggplot2")
library(ggplot2)

df <- data.frame(x = state.center$x, y = state.center$y,
                 state = state.name)

ggplot(df, aes(x = x, y = y, group = )) +
  geom_polygon(data = map_data("state"),
               color = "black",
               fill = "white",
               aes(x = long, y = lat,
                   group = group)) +
  geom_pushpin(pushpin = "orange", size = 1) +
  guides(fill = FALSE) +
  theme_void()
```


<p align="center">
 <img src="https://user-images.githubusercontent.com/67192157/104848323-bb1d9d00-58e4-11eb-9331-d12e543ccf00.png">
</p>


## Example 3

```r
# install.packages("ggplot2")
library(ggplot2)
# install.packages("maps")
library(maps)

world <- map_data("world")
head(world)

set.seed(2)
cities_visited <- world.cities[sample(1:nrow(world.cities), 20), ]
cities_to_visit <- world.cities[sample(1:nrow(world.cities), 15), ]

ggplot(data = world) +
  geom_polygon(aes(x = long, y = lat, group = group), fill = "white", color = "grey30", size = 0.1) + 
  geom_pushpin(cities_visited, mapping =  aes(x = long, y = lat, colour = "red", pushpin = "red"), size = 0.75) +
  geom_pushpin(cities_to_visit, mapping =  aes(x = long, y = lat, colour = "green", pushpin = "green"), size = 0.75) + 
  scale_color_manual(labels = c("Visited", "To visit"), values = c("red", "green")) +
  coord_sf(crs = 4087) +
  theme(panel.background = element_rect(fill = "#edd9af"),
        panel.grid = element_blank()) 
```


<p align="center">
 <img src="https://user-images.githubusercontent.com/67192157/104848385-020b9280-58e5-11eb-86e8-e5099f196011.png">
</p>

