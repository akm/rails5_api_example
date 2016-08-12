
$(function() {
    var App = {
        current_page: 1,
        template: null,

        init: function(){
            this.template = Hogan.compile($("#blogsArea").html());
            $(".linkToPrev").click(this.prevClick);
            $(".linkToNext").click(this.nextClick);
            $(".linkToLogin").click(this.loginClick);
        },

        refresh: function(){
            var self = this;
            var path = "/posts.json?page=" + this.current_page;
	        $.getJSON(path, {}).then(function(res) {
                $("#blogsArea").html( self.template.render({blogs: res.data}) );
	        });
        },

        showLoginDialog: function(){
        },

        prevClick: function(){
            App.current_page--;
            App.refresh();
        },

        nextClick: function(){
            App.current_page++;
            App.refresh();
        },

        loginClick: function(){
            App.showLoginDialog();
        }
    };

    App.init();
    App.refresh();
});
