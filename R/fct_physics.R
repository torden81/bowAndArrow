#' Calculate energy of drawn bow
#'
#' The energy content of a bow with a drawn string is approximated with a linear
#' increase of the draw weight per drawn length.
#'
#' @param draw_weight_pounds draw weight in pounds
#' @param draw_length_inches draw length in inches
#'
#' @return
#' @export
#'
#' @examples
#' draw_weight <- 20 # pounds
#' draw_length <- 28 # inches
#' energy_bow(draw_weight, draw_length)
energy_bow <- function(draw_weight_pounds, draw_length_inches){
  g <- 9.81  # Acceleration due to gravity (m/s²)
  draw_weight_kg <- draw_weight_pounds / 2.205
  draw_length_m <- draw_length_inches/39.37
  potential_energy<- 0.5 * draw_weight_kg * draw_length_m * g
  return(potential_energy)
}


#' Calculate the initial velocity of an arrow at string release
#'
#' @param E_pot potential energy
#' @param m arrow weight in kg
#'
#' @return
#' @export
#'
#' @examples
init_v <- function(E_pot, m){
  # kin energy
  # E_kin = 1/2 * m * v^2
  E_kin <- E_pot # energy balance: potential energy is converted to kinetic energy
  v <- sqrt(2 * E_kin / m)
  return(v)
}


#' Calculate flight of arrow
#'
#' The flight of the arrow is calculated with a given initial velocity of the arrow
#' at string release and the release angle.
#'
#' @param initial_velocity initial velocity in m/s
#' @param angle_degrees the angle at release in degrees relative to the ground
#'
#' @return
#' @export
#'
#' @examples
flight_arrow <- function(initial_velocity, angle_degrees){
  # Constants
  g <- 9.81  # Acceleration due to gravity (m/s²)

  # Convert angle from degrees to radians
  angle_radians <- angle_degrees * pi / 180

  # Split initial velocity into horizontal and vertical components
  initial_velocity_x <- initial_velocity * cos(angle_radians)
  initial_velocity_y <- initial_velocity * sin(angle_radians)

  # Calculate time of flight
  time_of_flight <- 2 * initial_velocity_y / g

  # Calculate maximum height
  max_height <- (initial_velocity_y)^2 / (2 * g)

  # Calculate range (horizontal distance)
  range <- initial_velocity_x * time_of_flight


  # Generate time points for trajectory plotting
  time_points <- seq(0, time_of_flight, length.out = 100)

  # Calculate positions (x, y) at each time point
  positions_x <- initial_velocity_x * time_points
  positions_y <- initial_velocity_y * time_points - 0.5 * g * time_points^2

  list(
    time_of_flight = time_of_flight,
    max_height = max_height,
    range = range,
    path = data.frame(x = positions_x, y = positions_y)
  )
}

#' Plot the flight of an arrow
#'
#' @param flight_data
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
plot_flight <- function(flight_data, ...){
  #browser()
  x <- flight_data[["path"]][,"x"]
  y <- flight_data[["path"]][,"y"]
  max_height <- flight_data[["max_height"]]
  # Plot the trajectory
  plot( y ~ x,
        type = "l",
        xlab = "Horizontal Distance (m)",
        ylab = "Vertical Height (m)",
        main = "Parabolic Flight Path of Arrow",
        xlim = c(0, max(x)),
        ylim = c(0, max_height),
        ...
  )
}
