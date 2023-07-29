#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic


  E_pot <- reactive(
    energy_bow(
      draw_weight_pounds = input[["drawWeight"]],
      draw_length_inches = input[["drawLength"]]
    )
  )

  velocity <- reactive(
    init_v(
      E_pot(),
      m = input[["arrowWeight"]]/1000
    )
  )


  flight <- reactive(
    flight_arrow(
      velocity(),
      angle_degrees = input[["angle"]]
    )
  )

  output[["flight_path_plot"]] <- renderPlot(
    plot_flight(flight(),
                max_x = input[["maxX"]],
                max_y = input[["maxY"]]
    ),
    bg = "transparent"
  )
}
