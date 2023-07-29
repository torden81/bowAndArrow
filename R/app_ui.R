#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic
    fluidPage(
      fluidRow(
        h1("Bow and Arrow")
      ),
      fluidRow(
        numericInput("drawWeight",
                     label = "Draw weight [pounds]",
                     value = 30,
                     min = 0),
        numericInput("drawLength",
                     label = "Draw length [inches]",
                     value = 28,
                     min = 0),
        numericInput("arrowWeight",
                     label = "Arrow weight [g]",
                     value = 300,
                     min = 0),
        numericInput("angle",
                     label = "Angle [deg]",
                     value = 45,
                     min = 0,
                     max = 90)
      ),
      fluidRow(
        wellPanel(
        shiny::plotOutput("flight_path_plot"),
        sliderInput(
          "maxX", "Distance",
          min = 0, max = 100,
          value = 30,
          step = 1
        ),
        sliderInput(
          "maxY", "Height",
          min = 0, max = 20,
          value = 10,
          step = 1
        )
        )
      )

    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path(
    "www",
    app_sys("app/www")
  )

  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys("app/www"),
      app_title = "bowAndArrow"
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
  )
}
