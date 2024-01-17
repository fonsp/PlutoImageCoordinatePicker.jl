### A Pluto.jl notebook ###
# v0.19.36

using Markdown
using InteractiveUtils

# ╔═╡ 556afd4e-b54e-11ee-3a1b-7b581fb5d9aa
using HypertextLiteral

# ╔═╡ 012c3ed5-6263-4dd7-8069-772f7efafdbb
using AbstractPlutoDingetjes

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

# ╔═╡ c8fa543d-9411-45ef-bf01-7dfe668653d4
struct ClickCoordinate
	width::Float64
	height::Float64
	x::Float64
	y::Float64
end

# ╔═╡ 5ba78d40-a1f3-4fe5-ab7a-723bc5b16d66
begin
	Base.@kwdef struct _ImgCoordinatePicker
		img_url::Union{AbstractString,Nothing}=nothing
		img_data::Union{Vector{UInt8},Nothing}=nothing 
		mime::Union{Nothing,MIME}=nothing
		draggable::Bool=true
		allow_only_one_event_per_render::Bool=false
	end


	AbstractPlutoDingetjes.Bonds.initial_value(picker::_ImgCoordinatePicker) = nothing
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
			<div style='touch-action: none;'>
				<img style='width: 100%; background: white;'>
			</div>
		`
		const img = wrapper.firstElementChild

		const img_url = $(picker.img_url)
		const img_data = $(AbstractPlutoDingetjes.Display.published_to_js(picker.img_data))
		const mime = $(picker.mime === nothing ? nothing : string(picker.mime))
		

		let url = img_url
		if(img_url == null){
			url = URL.createObjectURL(new Blob([img_data], { type: mime }))
			invalidation.then(() => {
				URL.revokeObjectURL(url)
			})
		}
		
		// Call `fetch` on the URL to trigger the browser to make it ready. 
		let fetch_promise = fetch(url)
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

		// If running for the first time
		if(this == null) {
			console.log("Creating new plotclicktracker...")
		
			const value = {current: null}
		
			Object.defineProperty(wrapper, "value", {
				get: () => value.current,
				set: (x) => {
					// not really necessary
					value.current = x
				},
			})
		
		
			////
			// Event listener for pointer move
		
			const clamp = (x,a,b) => Math.min(Math.max(x, a), b)
			const on_pointer_move = (e) => {

				const svgrect = img.getBoundingClientRect()
	
				if(!$(picker.allow_only_one_event_per_render) || wrapper.fired_already === false){
					console.log(e)
					value.current = new Float64Array([
						svgrect.width, 
						svgrect.height,
						clamp(e.clientX - svgrect.left, 0, svgrect.width),
						clamp(e.clientY - svgrect.top, 0, svgrect.height),
					])
	
					wrapper.fired_already = true
					wrapper.dispatchEvent(new CustomEvent("input"), {})
				}
			}

			////
			// Add the listeners

			wrapper.addEventListener("pointerdown", e => {
				window.getSelection().empty()
		
				if($(picker.draggable)){
					wrapper.addEventListener("pointermove", on_pointer_move);
				}
				on_pointer_move(e);
			});
			const mouseup = e => {
				wrapper.removeEventListener("pointermove", on_pointer_move);
			};
			document.addEventListener("pointerup", mouseup);
			document.addEventListener("pointerleave", mouseup);
			wrapper.onselectstart = () => false
		}
		return wrapper
		</script>""")

		show(io, m, h)
	end
end

# ╔═╡ 16bd9bea-26e9-4a08-b5ac-8209c495751d
ImageCoordinatePicker(;kwargs...) = _ImgCoordinatePicker(;kwargs...)

# ╔═╡ 9e3b3203-fd6c-48d4-b3d3-f8daaa0afe8a
#=╠═╡
@bind asdf ImageCoordinatePicker(img_data=img_data[2], mime=MIME("image/svg+xml"), draggable=true)
  ╠═╡ =#

# ╔═╡ e02d5785-b113-4133-88ea-123e34346693
#=╠═╡
asdf
  ╠═╡ =#

# ╔═╡ 406455a3-13f4-4736-9aae-0a5a629758cc
#=╠═╡
@bind asdf2 ImageCoordinatePicker(img_url=img_urls[3], draggable=true)
  ╠═╡ =#

# ╔═╡ 0e243fd6-083a-43f7-be51-c928e3c9bb7c
#=╠═╡
asdf2
  ╠═╡ =#

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
AbstractPlutoDingetjes = "6e696c72-6542-2067-7265-42206c756150"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"

[compat]
AbstractPlutoDingetjes = "~1.2.3"
HypertextLiteral = "~0.9.5"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.10.0"
manifest_format = "2.0"
project_hash = "70be3486f293846b1ddc7c639dfbf884afc3561e"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "c278dfab760520b8bb7e9511b968bf4ba38b7acc"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.2.3"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.4.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.6.4+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.2+1"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.1.10"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.10.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Tricks]]
git-tree-sha1 = "eae1bb484cd63b36999ee58be2de6c178105112f"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.8"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.52.0+1"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╠═556afd4e-b54e-11ee-3a1b-7b581fb5d9aa
# ╠═012c3ed5-6263-4dd7-8069-772f7efafdbb
# ╠═b368179a-e29d-407b-90fe-61d9812b3c22
# ╠═e03c0e08-4010-4eb9-8da2-8131ef0b3023
# ╠═9e3b3203-fd6c-48d4-b3d3-f8daaa0afe8a
# ╠═e02d5785-b113-4133-88ea-123e34346693
# ╠═406455a3-13f4-4736-9aae-0a5a629758cc
# ╠═0e243fd6-083a-43f7-be51-c928e3c9bb7c
# ╠═c8fa543d-9411-45ef-bf01-7dfe668653d4
# ╠═16bd9bea-26e9-4a08-b5ac-8209c495751d
# ╠═5ba78d40-a1f3-4fe5-ab7a-723bc5b16d66
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
