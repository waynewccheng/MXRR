https://www.r-project.org/
download installation package for Windows

in R:
Packages/Install packages:
choose "imager"
choose "magick"

** imager
im <- load.image('test.jpg')
plot(im)


** magick
im = image_read("test.jpg")
image_browse(im)
