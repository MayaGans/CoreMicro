context("Taxa mean, variance, and covariance")

dummy <- dplyr::tibble(
  X = c("a", "b", "c"),
  a = c(0,0,0),
  b = c(0,1,0),
  c = c(1,1,1)
)

test_that("taxa summary correct", {

  expect_equal(summarise_taxa(dummy)$Mean, c(1/3, 2/3, 1/3))
  expect_equal(summarise_taxa(dummy)$CV, c(1, 0.5, 1))
  expect_equal(summarise_taxa(dummy)$Variance, c(1/3, 1/3, 1/3))

})
