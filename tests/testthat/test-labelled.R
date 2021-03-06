context("Labelled")

test_that("x must be numeric or character", {
  expect_error(labelled(TRUE), "must be a numeric or a character vector")
})

test_that("x and labels must be compatible", {
  expect_error(labelled(1, "a"), "must be same type")
  expect_error(labelled(1, c(female = 2L, male = 1L)), NA)
  expect_error(labelled(1L, c(female = 2, male = 1)), NA)
})

test_that("labels must have names", {
  expect_error(labelled(1, 1), "must have names")
})

# methods -----------------------------------------------------------------

test_that("printed output is stable", {
  x <- labelled(1:5, c("Good" = 1, "Bad" = 5))
  expect_output_file(print(x), "labelled-output.txt")
})

# zap_labels --------------------------------------------------------------

test_that("zap_labels strips labelled attributes", {
  var <- labelled(c(1L, 98L, 99L),  c(not_answered = 98L, not_applicable = 99L))
  exp <- c(1L,98L,99L)
  expect_equal(zap_labels(var), exp)
})

test_that("zap_labels returns variables not of class('labelled') unmodified", {
  var <- c(1L, 98L, 99L)
  expect_equal(zap_labels(var), var)
})

test_that("zap_labels is applied to every column in data frame", {
  df <- tibble::data_frame(x = 1:10, y = labelled(10:1, c("good" = 1)))
  expect_equal(zap_labels(df)$y, 10:1)
})
