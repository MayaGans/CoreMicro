context("testing core methods")

# dummy dataset
dummy <- tidyr::tibble(
  X = c("OTU_1", "OTU_2", "OTU_3"),
  site_1 = c(30,0,10),
  site_2 = c(30,5,30),
  site_3 = c(30,1,15),
  site_4 = c(30,7,12),
  site_5 = c(30,8,9)
)

# same dataset but transposed
dummy_t <- tidyr::tibble(
    site = c("site_1", "site_2", "site_3", "site_4", "site_5"),
    OTU_1 = c(30,30,30,30,30),
    OTU_2 = c(0,5,1,7,8),
    OTU_3 = c(10,30,15,12,9)
)

test_that("hard cut off works", {
  expect_equal(hard_cutoff(dummy), "OTU_1")
  expect_equal(hard_cutoff(dummy_t, taxa_as_rows = FALSE), "OTU_1")
})

test_that("sum reads method works", {
  expect_equal(sum_reads(dummy), "OTU_1")
  expect_equal(sum_reads(dummy_t, taxa_as_rows = FALSE), "OTU_1")
})

test_that("prop reps method works", {
  expect_equal(prop_reps(dummy), c("OTU_1", "OTU_2", "OTU_3"))
  expect_equal(prop_reps(dummy_t, taxa_as_rows = FALSE), c("OTU_1", "OTU_2", "OTU_3"))
})

test_that("prop reads and reps method works", {
   expect_equal(prop_reads_and_reps(dummy), c("OTU_1", "OTU_2", "OTU_3"))
   expect_equal(prop_reads_and_reps(dummy_t, taxa_as_rows = FALSE), c("OTU_1", "OTU_2", "OTU_3"))
})

test_that("combining methods works", {
  values <- data.frame(core_methods(dummy)) %>% dplyr::arrange(name) %>% dplyr::pull(value)
  expect_equal(values, c(1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0))
})


test_that("combining methods works when transposed", {
  values <- data.frame(core_methods(dummy_t, taxa_as_rows = FALSE)) %>% dplyr::arrange(name) %>% dplyr::pull(value)
  expect_equal(values, c(1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0))
})

