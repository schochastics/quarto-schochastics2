library(magick)
pkgs <- jsonlite::fromJSON("https://schochastics.r-universe.dev/api/packages/")
image_read_na <- function(x) {
    if (is.na(x)) {
        return(NA)
    }
    return(image_read(x))
}
logos <- lapply(pkgs$`_pkglogo`, image_read_na)

if (!dir.exists("img/hex")) {
    dir.create("img/hex")
}

for (i in seq_along(pkgs$Package)) {
    p <- paste0("img/hex/", pkgs$Package[i], ".png")
    if (!is.na(logos[[i]])) {
        logo_small <- image_scale(logos[[i]], "20x")
    } else {
        logo_small <- image_read("img/logo.png")
    }
    image_write(logo_small, path = p, format = "png")
}
