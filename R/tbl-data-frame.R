# Grouping methods ------------------------------------------------------------

#' @export
regroup.data.frame <- function(x, value) {
  grouped_df(x, value)
}

#' @export
groups.data.frame <- function(x) NULL

#' @export
ungroup.data.frame <- function(x) x

#' @export
group_size.data.frame <- function(x) nrow(x)

#' @export
n_groups.data.frame <- function(x) 1L

# Manipulation functions ------------------------------------------------------

# These could potentially be rewritten to avoid any copies, but since this
# is just a convenience layer, I didn't bother. They should still be fast.

#' @export
filter.data.frame <- function(.data, ...) {
  as.data.frame(filter(tbl_df(.data), ...))
}
#' @export
slice.data.frame <- function(.data, ...) {
  as.data.frame(slice(tbl_df(.data), ...))
}
#' @export
summarise.data.frame <- function(.data, ...) {
  as.data.frame(summarise(tbl_df(.data), ...))
}
#' @export
mutate.data.frame <-  function(.data, ...) {
  tbl <- tbl_df(.data)
  res <- mutate.tbl_df(tbl, ...)
  as.data.frame(res)
}
#' @export
arrange.data.frame <- function(.data, ...) {
  as.data.frame(arrange(tbl_df(.data), ...))
}
#' @export
select_.data.frame <- function(.data, args) {
  args <- lazy::as.lazy_dots(args, parent.frame())
  vars <- select_vars_(names(.data), args)
  select_impl(.data, vars)
}
#' @export
rename.data.frame <- function(.data, ...) {
  vars <- rename_vars_(names(.data), lazy::lazy_dots(...))
  select_impl(.data, vars)
}


# Joins ------------------------------------------------------------------------

#' @export
inner_join.data.frame <- function(x, y, by = NULL, copy = FALSE, ...) {
  as.data.frame(inner_join(tbl_df(x), y, by = by, copy = copy, ...))
}

#' @export
left_join.data.frame <- function(x, y, by = NULL, copy = FALSE, ...) {
  as.data.frame(left_join(tbl_df(x), y, by = by, copy = copy, ...))
}

#' @export
semi_join.data.frame <- function(x, y, by = NULL, copy = FALSE, ...) {
  as.data.frame(semi_join(tbl_df(x), y, by = by, copy = copy, ...))
}

#' @export
anti_join.data.frame <- function(x, y, by = NULL, copy = FALSE, ...) {
  as.data.frame(anti_join(tbl_df(x), y, by = by, copy = copy, ...))
}

# Set operations ---------------------------------------------------------------

#' @export
intersect.data.frame <- function(x, y, ...) intersect_data_frame(x, y)

#' @export
union.data.frame <-     function(x, y, ...) union_data_frame(x, y)

#' @export
setdiff.data.frame <-   function(x, y, ...) setdiff_data_frame(x, y)

#' @export
setequal.data.frame <-  function(x, y, ...) equal_data_frame(x, y)


# Misc -------------------------------------------------------------------------

#' @export
collect.data.frame <- function(x, ...) x
#' @export
compute.data.frame <- function(x, ...) x
#' @export
collapse.data.frame <- function(x, ...) x
