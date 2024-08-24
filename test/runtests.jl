using PlutoImageCoordinatePicker
using Test

url1 = "https://s3-us-west-2.amazonaws.com/courses-images-archive-read-only/wp-content/uploads/sites/924/2016/06/23153103/CNX_Precalc_Figure_03_01_0022.jpg"


t1 = PlutoImageCoordinatePicker.ClickCoordinate(100, 200, 5, 6)


p1 = ImageCoordinatePicker(url1)
p2 = ImageCoordinatePicker(img_url=url1)
p3 = ImageCoordinatePicker(url1; pointer_url=PlutoImageCoordinatePicker.Pointers.Cross)
p4 = ImageCoordinatePicker(url1; pointer_url=PlutoImageCoordinatePicker.Pointers.CrossInverted, default=t1)




using AbstractPlutoDingetjes

@test AbstractPlutoDingetjes.Bonds.initial_value(p1) === nothing
@test AbstractPlutoDingetjes.Bonds.initial_value(p2) === nothing
@test AbstractPlutoDingetjes.Bonds.initial_value(p3) === nothing
@test AbstractPlutoDingetjes.Bonds.initial_value(p4) === t1
@test !isempty(repr(MIME"text/html"(), p1))
@test !isempty(repr(MIME"text/html"(), p2))
@test !isempty(repr(MIME"text/html"(), p3))
@test !isempty(repr(MIME"text/html"(), p4))
