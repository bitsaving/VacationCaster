if(location.search.match(/sw_lat/)){
	window.location = "https://localhost:3000/searches/new?options="+encodeURIComponent(location.search)
}else{
	alert("Can you please wiggle the map a little?")
}
