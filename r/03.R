#!/usr/bin/env Rscript --vanilla

library(magrittr)
suppressMessages(library(mgcv))
library(readr)

parse <- function(str) {
  raw.contents <- head(unlist(strsplit(str, '')), -1)

  n <- c(0, 1)
  e <- c(1, 0)
  s <- c(0, -1)
  w <- c(-1, 0)

  contents.list <- list(n, e, s, w)[match(raw.contents, c('^', '>', 'v', '<'))]
  do.call(rbind, contents.list)
}

side.a <- function(input) {
  positions <- cbind(cumsum(input[,1]), cumsum(input[,2]))
  positions %>% uniquecombs %>% nrow
}

side.b <- function(input) {
  anthro.input <- input[c(TRUE, FALSE),]
  robo.input <- input[c(FALSE, TRUE),]

  anthro.positions <- cbind(cumsum(anthro.input[,1]), cumsum(anthro.input[,2]))
  robo.positions <- cbind(cumsum(robo.input[,1]), cumsum(robo.input[,2]))

  all.positions <- rbind(anthro.positions, robo.positions)
  all.positions %>% uniquecombs %>% nrow
}

main <- function() {
  contents <- read_file('../input/03.txt')
  input <- parse(contents)
  cat(side.a(input), '\n')
  cat(side.b(input), '\n')
}

main()
