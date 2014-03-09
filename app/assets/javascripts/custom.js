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
	$(document).on("click", ".modal-link", function(e){
		e.preventDefault();
		var href = $(this).attr("href");
		$(".modal").modal({
			keyboard: false,
			remote: href
		});
		$.ajax({
			type: 'get',
			url: href,
			success:function(res){
				$(".modal-content").replaceWith(res);
			}
		});
	});
  $(document).on("click", ".modald input:submit", function(e){
    e.preventDefault();
    var form = $(this).parents("form");
    var form_data = form.serialize();
    var href = form.attr("action");
    $.ajax({
      url : href,
      type: 'post',
      data : form_data,
      success:function(res){
        if(res.text == "error"){
          $(".modal .modal-body").replaceWith(res);
          return false;
        }
      }
    });
  });
  $('#my-carousel').carousel({
    interval :false
  });
  $(".social-share-button a").click(function(){
    var share_link = $(this).parents(".share-wrapp").find(".share_link").val();
    var site_name = $(this).attr("data-site");
    $.ajax({
      url: share_link,
      data: "&site_name=" + site_name,
      success:function(res){
        
      }
    });
  });
});
