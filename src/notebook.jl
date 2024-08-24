### A Pluto.jl notebook ###
# v0.19.46

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 930e8bd4-d630-406a-a3f3-f73371c9d388
# ╠═╡ skip_as_script = true
#=╠═╡
begin
	import Pkg
	Pkg.activate(dirname(@__DIR__))
	Pkg.instantiate()
end
  ╠═╡ =#

# ╔═╡ 556afd4e-b54e-11ee-3a1b-7b581fb5d9aa
using HypertextLiteral

# ╔═╡ 012c3ed5-6263-4dd7-8069-772f7efafdbb
using AbstractPlutoDingetjes

# ╔═╡ af513821-9040-4393-a012-8ebe8dc88e4a
using Base64

# ╔═╡ b368179a-e29d-407b-90fe-61d9812b3c22
# ╠═╡ skip_as_script = true
#=╠═╡
img_urls = [
	"https://user-images.githubusercontent.com/6933510/80637344-24ac0180-8a5f-11ea-82dd-813dbceca9c9.gif",
	"https://raw.githubusercontent.com/gist/fonsp/9a36c183e2cad7c8fc30290ec95eb104/raw/ca3a38a61f95cd58d79d00b663a3c114d21e284e/cute.svg",
	"https://fonsp.com/img/doggoSmall.jpg?raw=true",
]
  ╠═╡ =#

# ╔═╡ e03c0e08-4010-4eb9-8da2-8131ef0b3023
#=╠═╡
img_data = map(img_urls) do url
	read(download(url))
end
  ╠═╡ =#

# ╔═╡ 1c798857-386b-4c3c-80d8-d6f18b635629
md"""
If you want to test with the packages below, you need to add them to your global Pkg environment.

**If there is an error below, that's fine, you just don't get to test it.**
"""

# ╔═╡ f3bb33e1-bf93-46c1-862d-8fd42d78b86f
# ╠═╡ skip_as_script = true
#=╠═╡
import Colors, ImageIO, ImageShow
  ╠═╡ =#

# ╔═╡ b9c72f75-bb13-46d5-a10a-548818cf82d0
#=╠═╡
test_img_from_images = rand(Colors.RGB, 100, 200)
  ╠═╡ =#

# ╔═╡ 354ba71e-9795-4d98-955d-4967ac25a7e5
md"""
# Definition
"""

# ╔═╡ c8fa543d-9411-45ef-bf01-7dfe668653d4
struct ClickCoordinate
	width::Float64
	height::Float64
	x::Float64
	y::Float64
end

# ╔═╡ 99c684f5-2776-406f-908b-a22cb9f0e7e5
function first_showable_mime(x)
	for m in (MIME"image/svg+xml"(), MIME"image/png"(), MIME"image/bmp"(), MIME"image/jpeg"(), MIME"image/gif"())
		if Base.showable(m, x)
			return m
		end
	end
end

# ╔═╡ a9d84510-0aeb-45ee-80e0-3caa227e05a3
ImageCoordinatePicker(url::String; kwargs...) = ImageCoordinatePicker(; kwargs..., img_url=url)

# ╔═╡ d58f15bd-2e5c-4ff0-b008-e32b1e04da86
ImageCoordinatePicker(data::AbstractVector{UInt8}; kwargs...) = ImageCoordinatePicker(; kwargs..., img_data=data)

# ╔═╡ becb4e51-ec3b-4077-b28c-a44d4c924a09
md"""
# Pointers
"""

# ╔═╡ 564fba60-0659-4909-87de-178cc207e94c
svg_data_to_url(d) = "data:image/svg+xml;base64,$(base64encode(d))"

# ╔═╡ 6ed0d836-beb5-4c7e-9cd4-83d47d4c66df
const Circle = """
<svg
width="20"
height="20"
  viewBox="0 0 20 20"
  xmlns="http://www.w3.org/2000/svg">
  <circle fill="white" stroke="black" cx="10" cy="10" r="8" stroke-width="4" />

</svg>

""" |> svg_data_to_url

# ╔═╡ 4d76ab73-13cd-49a2-97e2-f0b2f96a3e7b
const CircleInverted = """
<svg
width="20"
height="20"
  viewBox="0 0 20 20"
  xmlns="http://www.w3.org/2000/svg">
  <circle fill="black" stroke="white" cx="10" cy="10" r="8" stroke-width="4" />

</svg>

""" |> svg_data_to_url

# ╔═╡ 4655d43c-239e-43bb-8cf9-dba03ef1f3a2
const Cross = """
<svg
width="30"
height="30"
  viewBox="0 0 20 20"
  xmlns="http://www.w3.org/2000/svg">
  <line x1="0" x2="20" y1="10" y2="10" stroke="black" stroke-width="3" />
  <line y1="0" y2="20" x1="10" x2="10" stroke="black" stroke-width="3" />
  <line x1="1" x2="19" y1="10" y2="10" stroke="white" stroke-width="1" />
  <line y1="1" y2="19" x1="10" x2="10" stroke="white" stroke-width="1" />

</svg>

""" |> svg_data_to_url

# ╔═╡ 0890b5e2-bb82-4c44-910b-347850de98d8
const CrossInverted = """
<svg
width="30"
height="30"
  viewBox="0 0 20 20"
  xmlns="http://www.w3.org/2000/svg">
  <line x1="0" x2="20" y1="10" y2="10" stroke="white" stroke-width="3" />
  <line y1="0" y2="20" x1="10" x2="10" stroke="white" stroke-width="3" />
  <line x1="1" x2="19" y1="10" y2="10" stroke="black" stroke-width="1" />
  <line y1="1" y2="19" x1="10" x2="10" stroke="black" stroke-width="1" />

</svg>

""" |> svg_data_to_url

# ╔═╡ cf37e8d8-2134-4795-9ce7-cfbd08893f2d
const Pointers = (;
	Circle,
	CircleInverted,
	Cross,
	CrossInverted,
)

# ╔═╡ 5ba78d40-a1f3-4fe5-ab7a-723bc5b16d66
begin
	Base.@kwdef struct _ImgCoordinatePicker
		img_url::Union{AbstractString,Nothing}=nothing
		img_data::Union{AbstractVector{UInt8},Nothing}=nothing
		pointer_url::Union{AbstractString,Nothing}=Pointers.Circle
		default::Union{ClickCoordinate,Nothing}=nothing
		mime::Union{Nothing,MIME}=nothing
		img_style::AbstractString=""
		draggable::Bool=true
		allow_only_one_event_per_render::Bool=false
	end


	AbstractPlutoDingetjes.Bonds.initial_value(picker::_ImgCoordinatePicker) = picker.default
	AbstractPlutoDingetjes.Bonds.possible_values(picker::_ImgCoordinatePicker) = AbstractPlutoDingetjes.Bonds.InfinitePossibilities()


	
	function AbstractPlutoDingetjes.Bonds.transform_value(picker::_ImgCoordinatePicker, data)
		if data isa AbstractVector{Float64} && length(data) == 4
			ClickCoordinate(data...)
		else
			nothing
		end
	end

	function AbstractPlutoDingetjes.Bonds.validate_value(picker::_ImgCoordinatePicker, data::AbstractVector{Float64})
		length(data) == 4 && 
			0.0 <= data[3] <= data[1] && 
			0.0 <= data[4] <= data[2]
	end

	function Base.show(io::IO, m::MIME"text/html", picker::_ImgCoordinatePicker)
		@assert !(isnothing(picker.img_url) && isnothing(picker.img_data))

		h = @htl("""<script id="hello">

		const wrapper = this ?? html`
			<div class="PlutoImageCoordinatePicker" style='touch-action: none; position: relative;'>
				<img class="PlutoImageCoordinatePicker-image">
				<img class="PlutoImageCoordinatePicker-pointer" style="position: absolute; left: 0; top: 0; visibility: hidden; translate: -50% -50%; pointer-events: none;">
			</div>
		`
		const img = wrapper.firstElementChild
		const pointer_img = wrapper.lastElementChild
		img.style.cssText = $(picker.img_style)

		const img_url = $(picker.img_url)
		const img_data = $(picker.img_data === nothing ? nothing : AbstractPlutoDingetjes.Display.published_to_js(picker.img_data))
		const mime = $(picker.mime === nothing ? nothing : string(picker.mime))

		const pointer_url = $(picker.pointer_url)
		if(pointer_url != null) {
			pointer_img.src = pointer_url
		} else {
			// pointer_img.remove()
		}
		const set_pointer_pos = (x,y) => {
			if(x != null) {
				pointer_img.style.left = `\${x}px`
				pointer_img.style.top = `\${y}px`
				pointer_img.style.visibility = "visible"
			}
		}

		let url = img_url
		if(img_url == null){
			url = URL.createObjectURL(new Blob([img_data], { type: mime }))
			invalidation.then(() => {
				URL.revokeObjectURL(url)
			})
		}
		
		// Call `fetch` on the URL to trigger the browser to make it ready. 
		let fetch_promise = fetch(url, {mode: "no-cors"})
		Promise.race([
			fetch_promise, 
   			invalidation.then(x => null)
		]).then((r) => {
			if(r != null) {
				img.type = mime
				img.src = url
				img.draggable = false
			}
		})
		
		
		wrapper.fired_already = false
		wrapper.last_render_time = Date.now()

		const get_rendering_ratios = (svgrect) => {
			svgrect = svgrect ?? img.getBoundingClientRect()
			return [
				svgrect.width / (img.naturalWidth ?? svgrect.width),
				svgrect.height / (img.naturalHeight ?? svgrect.height),
			]
		}

		// If running for the first time
		if(this == null) {
			console.log("Creating new plotclicktracker...", wrapper.value)

			const defaultz = $(picker.default === nothing ? nothing : (picker.default.width, picker.default.height, picker.default.x, picker.default.y))
		
			const value = {current: defaultz == null ? null : new Float64Array(defaultz)}
		
			Object.defineProperty(wrapper, "value", {
				get: () => value.current,
				set: (pos) => {
					value.current = pos
					if(pos == null) {
						set_pointer_pos(null)
					} else {
						let [ratw, rath] = get_rendering_ratios()
						set_pointer_pos(pos[2] * ratw, pos[3] * rath)
					}
				},
			})
		
			if(defaultz) {
				wrapper.value = wrapper.value
			}
		
		
			////
			// Event listener for pointer move
		
			const clamp = (x,a,b) => Math.min(Math.max(x, a), b)
			const on_pointer_move = (e) => {

				const svgrect = img.getBoundingClientRect()
	
				if(!$(picker.allow_only_one_event_per_render) || wrapper.fired_already === false){
					let [ratw, rath] = get_rendering_ratios(svgrect)

					let inputx = clamp(e.clientX - svgrect.left, 0, svgrect.width)
					let inputy = clamp(e.clientY - svgrect.top, 0, svgrect.height)
		
					value.current = new Float64Array([
						svgrect.width / ratw, 
						svgrect.height / rath,
						inputx / ratw,
						inputy / rath,
					])

					set_pointer_pos(inputx, inputy)
		
					wrapper.fired_already = true
					wrapper.dispatchEvent(new CustomEvent("input"), {})
				}
			}

			const on_img_load = () => {
				wrapper.value = wrapper.value
			}

			////
			// Add the listeners

			wrapper.addEventListener("pointerdown", e => {
				window.getSelection().empty()
		
				if($(picker.draggable)){
					window.addEventListener("pointermove", on_pointer_move);
				}
				on_pointer_move(e);
			});
			const mouseup = e => {
				window.removeEventListener("pointermove", on_pointer_move);
			};
			document.addEventListener("pointerup", mouseup);
			document.addEventListener("pointerleave", mouseup);
			window.addEventListener("resize", on_img_load)
			img.addEventListener("load", on_img_load)
			// wrapper.onselectstart = () => false


			// uhhh no because it might re-render...
			/* invalidation.then(() => {
				window.removeEventListener("pointermove", on_pointer_move);
				
				document.removeEventListener("pointerup", mouseup);
				document.removeEventListener("pointerleave", mouseup);
			}) */
		}
		return wrapper
		</script>""")

		show(io, m, h)
	end
end

# ╔═╡ 16bd9bea-26e9-4a08-b5ac-8209c495751d
"""
```julia
ImageCoordinatePicker(image_url::String; kwargs...)

ImageCoordinatePicker(image_data::Vector{UInt8}; mime=MIME("image/png"), kwargs...)
```

Create a widget that displays the provided image, and captures all mouse / touch actions on it. Pointer events are sent back with `$("@")bind`, as a [`ClickCoordinate`](@ref) object.


# Example

```julia
img_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Eurasian_coot_%28Fulica_atra%29_with_chicks.jpg/640px-Eurasian_coot_%28Fulica_atra%29_with_chicks.jpg"
```

```julia
$("@")bind coord ImageCoordinatePicker(img_url=img_url)
```

```julia
# Let's look at what we got:
coord
```

You will see the image, and when you click somewhere, `coords` is updated.

# Default
Before you click for the first time, the `@bind` value will be `nothing`. If you want to change this, you can **set the intially clicked coordinate** with the `default` kwarg. You set it to a [`PlutoImageCoordinatePicker.ClickCoordinate`](@ref) instance.

Tip: use your picker without a default value and click where you want the initial point to be. Then copy the bound value.

# Pointer
You can pick a **pointer** (aka cursor) image that is shown on the selected point. By default, this is a small circle. The [`PlutoImageCoordinatePicker.Pointers`](@ref) object contains some common options.

```julia
import PlutoImageCoordinatePicker: Pointers
ImageCoordinatePicker(img_url=img_url, pointer_url=Pointers.Cross)
```

`pointer_url` can also be the URL of an image, which will be displayed at full size, centered around the clicked point. If you have an SVG image, you can use it like so:

```julia
svg_data = "<svg width="30" ...> ... </svg>"
pointer_url = "data:image/svg+xml;base64,\$(Base64.base64encode(svg_data))"
```

# Full form with all kwargs:

```julia
ImageCoordinatePicker(;
	# option 1) a URL
	img_url::Union{AbstractString,Nothing}=nothing,
	# option 2) image data with a MIME
	img_data::Union{AbstractVector{UInt8},Nothing}=nothing,
	mime::Union{Nothing,MIME}=nothing,

	## more options:
	# when holding down the mouse, send multiple events?
	draggable::Bool=true,
	# this image will be displayed on the selected point. 
	pointer::Union{AbstractString,Nothing}=Pointers.Circle,
	
	# CSS style the image. Set to "width: 100%;" to fill width.
	img_style=nothing,
	# advanced
	allow_only_one_event_per_render::Bool=false,
)
```

"""
ImageCoordinatePicker(;kwargs...) = _ImgCoordinatePicker(;kwargs...)

# ╔═╡ 4dc49d49-11db-468e-bcc2-a0ae9d2aea28
function ImageCoordinatePicker(thing::Any; kwargs...)
	mime = if haskey(kwargs, :mime)
		values(kwargs).mime
	else
		m = first_showable_mime(thing)
		if m === nothing
			throw(ArgumentError("Called ImageCoordinatePicker(x) but x is not something that can be displayed as an image (svg, png)."))
		end
		m
	end::MIME

	img_data = let
		io = IOBuffer()
		show(io, mime, thing)
		take!(io)
	end

	ImageCoordinatePicker(; kwargs..., img_data, mime)
end

# ╔═╡ 9e3b3203-fd6c-48d4-b3d3-f8daaa0afe8a
#=╠═╡
@bind asdf ImageCoordinatePicker(img_data=img_data[2], mime=MIME("image/svg+xml"), draggable=true; pointer_url=Pointers.Circle)
  ╠═╡ =#

# ╔═╡ e02d5785-b113-4133-88ea-123e34346693
#=╠═╡
asdf
  ╠═╡ =#

# ╔═╡ 406455a3-13f4-4736-9aae-0a5a629758cc
#=╠═╡
@bind asdf2 ImageCoordinatePicker(pointer_url=Pointers.Cross, img_url=img_urls[3], draggable=true)
  ╠═╡ =#

# ╔═╡ 0e243fd6-083a-43f7-be51-c928e3c9bb7c
#=╠═╡
asdf2
  ╠═╡ =#

# ╔═╡ 9eb0d291-9941-49fc-a367-ddd3df198691
#=╠═╡
@bind aa1 ImageCoordinatePicker(test_img_from_images; mime=MIME"image/png"(), draggable=false)
  ╠═╡ =#

# ╔═╡ ab262eee-a3a0-42c4-b027-7c10f9111995
#=╠═╡
aa1
  ╠═╡ =#

# ╔═╡ b715c7fc-cbe6-4e76-8ddf-49febbee09ea
#=╠═╡
@bind aa2 ImageCoordinatePicker(test_img_from_images; mime=MIME"image/svg+xml"())
  ╠═╡ =#

# ╔═╡ 90454ba9-a31b-45cb-8e2d-38af7b0a4a09
#=╠═╡
aa2
  ╠═╡ =#

# ╔═╡ 57ee02be-2aec-4a88-b2b9-7cd394d4f441
#=╠═╡
@bind aa3 ImageCoordinatePicker(test_img_from_images)
  ╠═╡ =#

# ╔═╡ c9c6eb07-9ca9-4361-9fb6-00c4562d257d
#=╠═╡
aa3
  ╠═╡ =#

# ╔═╡ f96be87c-8c8d-4767-9f41-a059788beb24
#=╠═╡
ImageCoordinatePicker(test_img_from_images; img_style="filter: grayscale(1); width: 150px;")
  ╠═╡ =#

# ╔═╡ 3bbdfce9-ed1b-4e2d-963b-9752011a1fec
# ╠═╡ skip_as_script = true
#=╠═╡
@bind nonono ImageCoordinatePicker(rand(5))
  ╠═╡ =#

# ╔═╡ de9a04d2-3f2c-463c-a499-f4e40cac317a
# ╠═╡ skip_as_script = true
#=╠═╡
@bind yesscord ImageCoordinatePicker("https://s3-us-west-2.amazonaws.com/courses-images-archive-read-only/wp-content/uploads/sites/924/2016/06/23153103/CNX_Precalc_Figure_03_01_0022.jpg"; pointer_url=Pointers.Circle,
default=ClickCoordinate(9000, 500, 100, 250))
  ╠═╡ =#

# ╔═╡ 1a62bc39-80a5-4d8c-929f-f3af4d1cdef1
#=╠═╡
yesscord
  ╠═╡ =#

# ╔═╡ 0d9fb8a4-b05a-4ca6-8059-3e26b7585eb7
# ╠═╡ skip_as_script = true
#=╠═╡
preview_svg(d) = @htl "<img src=$d >"
  ╠═╡ =#

# ╔═╡ 85e5189d-a459-4237-ab96-898242286fb3
#=╠═╡
map(preview_svg, Pointers)
  ╠═╡ =#

# ╔═╡ Cell order:
# ╠═930e8bd4-d630-406a-a3f3-f73371c9d388
# ╠═556afd4e-b54e-11ee-3a1b-7b581fb5d9aa
# ╠═012c3ed5-6263-4dd7-8069-772f7efafdbb
# ╠═b368179a-e29d-407b-90fe-61d9812b3c22
# ╠═e03c0e08-4010-4eb9-8da2-8131ef0b3023
# ╠═9e3b3203-fd6c-48d4-b3d3-f8daaa0afe8a
# ╠═e02d5785-b113-4133-88ea-123e34346693
# ╠═406455a3-13f4-4736-9aae-0a5a629758cc
# ╠═0e243fd6-083a-43f7-be51-c928e3c9bb7c
# ╟─1c798857-386b-4c3c-80d8-d6f18b635629
# ╠═f3bb33e1-bf93-46c1-862d-8fd42d78b86f
# ╠═b9c72f75-bb13-46d5-a10a-548818cf82d0
# ╠═9eb0d291-9941-49fc-a367-ddd3df198691
# ╠═ab262eee-a3a0-42c4-b027-7c10f9111995
# ╠═b715c7fc-cbe6-4e76-8ddf-49febbee09ea
# ╠═90454ba9-a31b-45cb-8e2d-38af7b0a4a09
# ╠═57ee02be-2aec-4a88-b2b9-7cd394d4f441
# ╠═c9c6eb07-9ca9-4361-9fb6-00c4562d257d
# ╠═f96be87c-8c8d-4767-9f41-a059788beb24
# ╠═3bbdfce9-ed1b-4e2d-963b-9752011a1fec
# ╟─de9a04d2-3f2c-463c-a499-f4e40cac317a
# ╠═1a62bc39-80a5-4d8c-929f-f3af4d1cdef1
# ╟─354ba71e-9795-4d98-955d-4967ac25a7e5
# ╠═c8fa543d-9411-45ef-bf01-7dfe668653d4
# ╠═16bd9bea-26e9-4a08-b5ac-8209c495751d
# ╠═99c684f5-2776-406f-908b-a22cb9f0e7e5
# ╠═a9d84510-0aeb-45ee-80e0-3caa227e05a3
# ╠═d58f15bd-2e5c-4ff0-b008-e32b1e04da86
# ╠═4dc49d49-11db-468e-bcc2-a0ae9d2aea28
# ╠═5ba78d40-a1f3-4fe5-ab7a-723bc5b16d66
# ╟─becb4e51-ec3b-4077-b28c-a44d4c924a09
# ╠═af513821-9040-4393-a012-8ebe8dc88e4a
# ╠═564fba60-0659-4909-87de-178cc207e94c
# ╟─6ed0d836-beb5-4c7e-9cd4-83d47d4c66df
# ╟─4d76ab73-13cd-49a2-97e2-f0b2f96a3e7b
# ╟─4655d43c-239e-43bb-8cf9-dba03ef1f3a2
# ╟─0890b5e2-bb82-4c44-910b-347850de98d8
# ╟─cf37e8d8-2134-4795-9ce7-cfbd08893f2d
# ╠═85e5189d-a459-4237-ab96-898242286fb3
# ╟─0d9fb8a4-b05a-4ca6-8059-3e26b7585eb7
