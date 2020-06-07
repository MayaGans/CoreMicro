context("testing core methods")

dummy <- tidyr::tibble(
  X = c("OTU_1", "OTU_2", "OTU_3"),
  site_1 = c(30,0,10),
  site_2 = c(30,5,30),
  site_3 = c(30,1,15),
  site_4 = c(30,7,12),
  site_5 = c(30,8,9)
)

test_that("hard cut off works", {
  expect_equal(hard_cutoff(dummy), "OTU_1")
})

test_that("prop reads method works", {
  expect_equal(prop_reads(dummy), "OTU_1")
})

test_that("prop reps method works", {
  expect_equal(prop_reps(dummy), c("OTU_1", "OTU_3"))
})

test_that("prop reads and reps method works", {
  expect_equal(prop_reads_and_reps(dummy), c("OTU_1", "OTU_2", "OTU_3"))
})

test_that("combining methods works", {
  values <- core_methods(dummy) %>% dplyr::arrange(name) %>% dplyr::pull(value)
  expect_equal(values, c(1,0,0,1,0,1,1,1,1,1,0,0))
})
