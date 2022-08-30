# Apache Arrow in R workshop tutorial
# last updated 2022-08-30

# Quick start guide ----

# Download a copy of the git repo
usethis::create_from_github(
  repo_spec = "djnavarro/arrow-user2022", 
  destdir="."
)

# Install the package dependencies
remotes::install_deps()
