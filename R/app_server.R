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

  # Info boxes ----
  output$flighttime <-  renderUI({
    shinydashboard::infoBox(
      "Flight time", flight()$time_of_flight %>% round(1), "s",
      icon = icon("clock", lib = "font-awesome"),
      color = "green", width = 12
    )
  })
  output$maxheight <-  renderUI({
    shinydashboard::infoBox(
      "Max. height", flight()$max_height %>% round(1),
      icon = icon("ruler-vertical", lib = "font-awesome"),
      color = "green", width = 12
    )
  })

  output$flightdistance <-  renderUI({
    shinydashboard::infoBox(
      "Distance", flight()$range %>% round(1),
      icon = icon("ruler-horizontal", lib = "font-awesome"),
      color = "green", width = 12
    )
  })
  output$speedrelease <-  renderUI({
    shinydashboard::infoBox(
      "Speed at release", velocity() %>% round(1),
      icon = icon("tachometer-alt", lib = "font-awesome"),
      color = "green", width = 12
    )
  })

  # infoBoxOutput("flighttime"),
  # infoBoxOutput("maxheight"),
  # infoBoxOutput("flightdistance"),
  # infoBoxOutput("speedrelease")

  output[["version_txt"]] <- renderUI(
    tagList(
      HTML(
        as.character(packageVersion("bowAndArrow"))
      ),
      shiny::tags$br(),
      shiny::tags$a("source code on github", href= "https://github.com/torden81/bowAndArrow")
    )

    )

}
