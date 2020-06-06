context("core plots")

test_that("combined plot works", {

})

test_that("combined plot exits if not class combined_methods", {
  expect_error(combine_plots(iris))
})
