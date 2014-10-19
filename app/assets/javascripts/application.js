// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


function AirbnbSearchOptions(){
	var location = ""
	var guests = 1;
	var lo_price = undefined;
	var hi_price = undefined;
	var room_types = undefined;
	var presetLocation = {
		napa: "sw_lat=38.27949015559621&sw_lng=-122.42621899097423&ne_lat=38.52682495084167&ne_lng=-122.0671033903883",
		soma: "neighborhoods%5B%5D=SoMa",
		lake_tahoe: "neighborhoods%5B%5D=North+Lake+Tahoe+Region&neighborhoods%5B%5D=North+Lake+Tahoe&neighborhoods%5B%5D=South+Lake+Tahoe+Region&neighborhoods%5B%5D=Carnelian+Bay&neighborhoods%5B%5D=Dollar+Point%2FRidgewood&neighborhoods%5B%5D=Homewood&neighborhoods%5B%5D=Incline+Village&neighborhoods%5B%5D=Kings+Beach%2FTahoe+Vista&neighborhoods%5B%5D=Kingsbury&neighborhoods%5B%5D=Meeks+Bay&neighborhoods%5B%5D=South+Lake+Tahoe&neighborhoods%5B%5D=Stateline&neighborhoods%5B%5D=Tahoe+City&neighborhoods%5B%5D=Tahoe+Pines&neighborhoods%5B%5D=Tahoma&neighborhoods%5B%5D=West+Shore&neighborhoods%5B%5D=Zephyr+Cove"
	}
	var room_types_options = {
		"Entire home/apt": "&room_types%5B%5D=Entire+home%2Fapt",
		"Private room": "&room_types%5B%5D=Private+room",
		"Shared room": "&room_types%5B%5D=Shared+room"
	}
	return {
		setLocation: function(key_or_location){
			location = presetLocation[key_or_location]
			if(location===undefined){
				location = key_or_location
			}
		},
		setGuests: function(guests_count){
			guests=guests_count;
		},
		setPrice: function(prices){
			lo_price = prices[0];
			hi_price = prices[1];
		},
		isLocationSet: function(){
			return (location !== "");
		},
		setRoomType: function(all_three){
			room_types = all_three.map(function(key){
				return room_types_options[key]
			}).join("")
		},
		buildQ: function(){
			var q;
			q = "?"+location+"&guests="+guests;
			if(typeof lo_price!=="undefined"){
				q += "&price_min="+lo_price
			}
			if(typeof hi_price!=="undefined"){
				q += "&price_max="+hi_price
			}
			if(typeof room_types!=="undefined"){
				q += room_types
			}
			return q;
		}
	}
}

function SearchSummary(){

	var selectors = {
		guests: $("#summary .guests"),
		timeframe: $("#summary .duration"),
		location: $("#summary .location"),
		price: $("#summary .range")
	}
	return {
		setGuests: function(count){
			var sel = selectors.guests
			if(count==1){
				str = "1 guest"
			}else{
				str = count + " guests"
			}
			sel.text(str)
		},
		setTimeFrame: function(text){
			sel = selectors.timeframe
			sel.text(text)
		},
		setLocation: function(text){
			sel = selectors.location
			sel.text(text)
		},
		setPrice: function(values){
			sel = selectors.price;
			sel.text("$"+values[0]+" and $"+values[1]);
		}
	}
}

function init(){
	window.searchSummary = new SearchSummary()
	window.searchOptions = new AirbnbSearchOptions();
	var $roomTypeCheckBoxes = $(".room_type input:checkbox");
	var $low_price  = $(".low_price")
	var $high_price = $(".high_price")
	var $slider = $("#ex2")
	var $guestsSelect = $("select#guests")
	var $locationImages = $(".location_image_list")
	var $options = $("input#search_options")

	$('#email').tooltip()
	$("#email").blur(function(){
		$("#search_email").val(this.value)
	})
  $locationImages.on('click', 'a',function(){
  	searchOptions.setLocation(this.getAttribute("data-location"))
  	$options.val(searchOptions.buildQ())
  	searchSummary.setLocation(this.getAttribute("data-human-readable"))
  	$("#search_name").val("Going to "+this.getAttribute("data-human-readable"))
  	$sceachStuff = $("#searchStuff")
  	$("#searchStuff")
  		.fadeIn(function(){ $.scrollTo($sceachStuff) })
  		.removeClass('hidden')
  	return false;
  })
  $guestsSelect.on("change",function(){
  	searchOptions.setGuests(this.value)
  	$options.val(searchOptions.buildQ())
  	searchSummary.setGuests(this.value)
  })

  $(".search_timeframe").on("click","a",function(){
  	$(".search_timeframe .active").removeClass("active")
  	$(this).addClass("active")
  	var start_date = this.getAttribute("data-start-date");
  	var end_date = this.getAttribute("data-end-date");
  	$("#search_start_date").val(start_date);
  	$("#search_end_date").val(end_date);
  	$options.val(searchOptions.buildQ());
  	searchSummary.setTimeFrame(this.getAttribute("data-desc"))
  	if(searchOptions.isLocationSet()){
  		$("#create_new_search_btn").attr('disabled', false)
  	}
  	return false;
  })
  price_slider = $slider.slider({}).on("slide", function(slideEvt) {
		$low_price.text("$"+slideEvt.value[0]);
		$high_price.text("$"+slideEvt.value[1]);
		searchSummary.setPrice(slideEvt.value)
		searchOptions.setPrice(slideEvt.value)
		$options.val(searchOptions.buildQ())
	});
	$roomTypeCheckBoxes.on("click",function(){
		var checked_boxes = $(".room_type input:checkbox:checked")
		selected_values = checked_boxes.map(function(){ return this.value; })
		selected_room_types = Array.prototype.slice.call(selected_values)
		searchOptions.setRoomType(selected_room_types)
		$options.val(searchOptions.buildQ())
	})
	$("start_watching").on("click",function(){

		$("form#new_search").submit()
	})
}
$(function(){
	init();
})
