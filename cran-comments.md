## Test environments

* local R installation (Windows 11), R 4.5.1
* local R installation (macOS), R 4.5.1
* ubuntu-latest (on GitHub Actions), (oldrel-1, devel, and release)
* windows-latest (on GitHub Actions), (release)
* macOS-latest (on GitHub Actions), (release)
* Windows (on Winbuilder), (devel and release)

## R CMD check results

0 errors | 0 warnings | 0 notes

## Additional notes

* This fixes the `scale_fill_538()` and `scale_color_538()` functions that were broken in ggplot2 4.0.0.
