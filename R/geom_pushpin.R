# pushpinGrob
pushpinGrob <- function(x, y, size, pushpin, geom_key = list(red = "red.png",
                                                             blue = "blue.png",
                                                             green = "green.png",
                                                             yellow = "yellow.png",
                                                             orange = "orange.png",
                                                             gray = "gray.png",
                                                             white = "white.png",
                                                             transparent = "transparent.png")) {

  filename <- system.file(geom_key[[unique(pushpin)]], package = "chinchet", mustWork = TRUE)
  img <- as.raster(png::readPNG(filename))

  # rasterGrob
  grid::rasterGrob(x             = x,
                   y             = y,
                   image         = img,
                   # only set height so that the width scales proportionally and so that the icon
                   # stays the same size regardless of the dimensions of the plot
                   height        = size * ggplot2::unit(20, "mm"))
}

# GeomPushpin
GeomPushpin <- ggplot2::ggproto(`_class` = "GeomPushpin",
                                `_inherit` = ggplot2::Geom,
                                required_aes = c("x", "y"),
                                non_missing_aes = c("size", "pushpin"),
                                default_aes = ggplot2::aes(size = 1, pushpin = "red", shape  = 19,
                                                           colour = "black"),

                                draw_panel = function(data, panel_scales, coord, na.rm = FALSE) {
                                  coords <- coord$transform(data, panel_scales)
                                  ggplot2:::ggname(prefix = "geom_pushpin",
                                                  grob = pushpinGrob(x = coords$x,
                                                                     y = coords$y,
                                                                     size = coords$size,
                                                                     pushpin = coords$pushpin))
                             })

#' @title Pushpin layer
#' @description The geom is used to add pushpins to plots. See ?ggplot2::geom_points for more info. The pushpin indicates the exact point on the pin point. Use the argument `pushpin` to select the color. Available options are `"red"` (default), `"blue"`, `"green"`, `"yellow"`, `"orange"`, `"gray"`, `"white"` and `"transparent"`. Change the size of the puspin with `size` as in `ggplot2::geom_point`
#' @inheritParams ggplot2::geom_point
#' @examples
#'
#' # install.packages("ggplot2")
#'library(ggplot2)
#'
#'
#'df <- data.frame(x = state.center$x, y = state.center$y,
#'                 state = state.name)
#'
#'ggplot(df, aes(x = x, y = y)) +
#'  geom_polygon(data = map_data("state"),
#'               color = "black",
#'               fill = "white",
#'               aes(x = long, y = lat,
#'                   group = group)) +
#'  geom_pushpin(pushpin = "blue", size = 1) +
#'  guides(fill = FALSE) +
#'  theme_void()
#'
#' @importFrom grDevices as.raster
#' @export
geom_pushpin <- function(mapping = NULL,
                      data = NULL,
                      stat = "identity",
                      position = "identity",
                      ...,
                      na.rm = FALSE,
                      show.legend = NA,
                      inherit.aes = TRUE) {

  ggplot2::layer(data = data,
                 mapping = mapping,
                 stat = stat,
                 geom = GeomPushpin,
                 position = position,
                 show.legend = show.legend,
                 inherit.aes = inherit.aes,
                 params = list(na.rm = na.rm, ...))
}


library(ggplot2)
library(maps)

world <- map_data("world")
head(world)

set.seed(2)
cities_visited <- world.cities[sample(1:nrow(world.cities), 10), ]
cities_to_visit <- world.cities[sample(1:nrow(world.cities), 10), ]

ggplot(data = world) +
  geom_polygon(aes(x = long, y = lat, group = group), fill = "white", color = 1, size = 0.1) +
  geom_pushpin(cities_visited, mapping =  aes(x = long, y = lat, pushpin = "red")) +
  geom_pushpin(cities_to_visit, mapping =  aes(x = long, y = lat, pushpin = "green")) +
  theme_void()
