#' Convert words from UK to US English
#' 
#' \code{convert_uk2us} converts a vector of words from UK to US English.
#' 
#' @param x Vector of words to convert.
#' @param crosswalk Data frame with columns \code{uk} and \code{us}.
#' 
#' @return A vector of converted words.
#' 
#' @seealso \code{\link{convert_us2uk}}
#' 
#' @examples
#' convert_uk2us(c("centre", "colour", "colourize"))
#' 
#' @export
convert_uk2us <- function(x, crosswalk = uk2us::ukus_crosswalk) {
  locs <- match(tolower(x), crosswalk[[1]])
  x[!is.na(locs)] <- crosswalk[locs[!is.na(locs)], ][[2]]
  x
}

#' Convert words from US to UK English
#' 
#' \code{convert_us2uk} converts a vector of words from US to UK English.
#' 
#' @param x Vector of words to convert.
#' @param crosswalk Data frame with columns \code{uk} and \code{us}.
#' 
#' @return A vector of converted words.
#' 
#' @seealso \code{\link{convert_uk2us}}
#' 
#' @examples
#' convert_us2uk(c("center", "color", "colorize"))
#' 
#' @export
convert_us2uk <- function(x, crosswalk = uk2us::ukus_crosswalk) {
  locs <- match(tolower(x), crosswalk[[2]])
  x[!is.na(locs)] <- crosswalk[locs[!is.na(locs)], ][[1]]
  x
}
