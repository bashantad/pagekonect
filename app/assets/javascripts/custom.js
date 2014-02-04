$(document).ready(function() {
	$('#search.typeahead').typeahead({
		name: 'twitter-oss',
		prefetch: '../pages/all/search',
		template: [
		'<p class="repo-language">{{language}}</p>',
		'<p class="repo-name">{{name}}</p>',
		'<p class="repo-description">{{description}}</p>'
		].join(''),
		engine: Hogan
	});
	$(document).on("click", ".flash-msg .close", function(){
		 $(this).parents(".flash-msg").remove();
	 });
	 $(".popover-btn").popover({
	 	  trigger :'focus hover', 
	    placement: 'top'
	 });
});
