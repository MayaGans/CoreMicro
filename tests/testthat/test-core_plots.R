context("core plots")

test_that("Plot returns ggplot object",{
  p <- core_plots(core_methods(arabidopsis[1:5,1:5]))
  expect_is(p,"ggplot")
})

test_that("Plot uses correct data", {
  p <- core_plots(core_methods(arabidopsis[1:5,1:5]))
  expect_that(core_methods(arabidopsis[1:5,1:5]), equals(p$data))
})

test_that("Plot layers match expectations", {
  p <- core_plots(core_methods(arabidopsis[1:5,1:5]))
  expect_identical(p$labels$fill, "Taxa Count")
  expect_identical(p$labels$y, "Coefficient of Variance")
  expect_identical(p$labels$x, "log(Mean)")
  expect_identical(p$labels$colour, "as.factor(value)")
  expect_identical(p$labels$weight, "weight")
})

test_that("combined plot exits if not class combined_methods", {
  expect_error(core_plots(iris))
})
