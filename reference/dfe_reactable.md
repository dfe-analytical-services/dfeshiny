# Department for Education Reactable Wrapper

**\[deprecated\]**

A wrapper around
[`shinyGovstyle::govReactable()`](https://rdrr.io/pkg/shinyGovstyle/man/govReactable.html),
preserving the function here in dfeshiny for backwards compatibility in
upcoming versions only.

All logic and documentation is now in
[`shinyGovstyle::govReactable()`](https://rdrr.io/pkg/shinyGovstyle/man/govReactable.html),
so please refer to that function for more information, and update your
code to use that function directly.

## Usage

``` r
dfe_reactable(data, ...)
```

## Arguments

- data:

  A data frame to display in the table.

- ...:

  Arguments passed to
  [`shinyGovstyle::govReactable()`](https://rdrr.io/pkg/shinyGovstyle/man/govReactable.html).

## Value

The result of `shinyGovstyle::govReactable(...)`.

## See also

[`shinyGovstyle::govReactable()`](https://rdrr.io/pkg/shinyGovstyle/man/govReactable.html)
