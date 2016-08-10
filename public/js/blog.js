
$(function() {
    var App = {
        current_page: 1,
        template: null,

        init: function(){
            this.template = Hogan.compile($("#blogsArea").html());
            $(".linkToPrev").click(this.prevClick);
            $(".linkToNext").click(this.nextClick);
        },

        refresh: function(){
            var self = this;
            var path = "/posts.json?page=" + this.current_page;
	        $.getJSON(path, {}, function(res) {
                var renderdArray = res.data.map(function(blog) {
				    return self.template.render(blog);
	            });
		        $("#blogsArea").html(renderdArray.join(" "));
	        });
        },

        prevClick: function(){
            App.current_page--;
            App.refresh();
        },

        nextClick: function(){
            App.current_page++;
            App.refresh();
        },
    };

    App.init();
    App.refresh();
});
