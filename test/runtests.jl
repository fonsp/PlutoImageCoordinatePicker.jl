using PlutoImageCoordinatePicker
using Test

p1 = ImageCoordinatePicker("https://s3-us-west-2.amazonaws.com/courses-images-archive-read-only/wp-content/uploads/sites/924/2016/06/23153103/CNX_Precalc_Figure_03_01_0022.jpg")


using AbstractPlutoDingetjes

@test AbstractPlutoDingetjes.Bonds.initial_value(p1) === nothing
@test !isempty(repr(MIME"text/html"(), p1))
