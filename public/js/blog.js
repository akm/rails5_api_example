
$(function() {
    var App = {
        current_page: 1,
        template: null,
        current_user_token: null,
        current_user_name: null,

        init: function(){
            this.template = Hogan.compile($("#blogsArea").html());
            this.logout();
            $(".linkToPrev").click(this.prevClick);
            $(".linkToNext").click(this.nextClick);
            $(".linkToLogin").click(this.loginClick);
            $(".linkToLogout").click(this.logoutClick);
            $(".form-signin").submit(this.loginSubmit);
        },

        refresh: function(){
            var self = this;
            var path = "/posts.json?page=" + this.current_page;
	        $.getJSON(path, {}).then(function(res) {
                $("#blogsArea").html( self.template.render({blogs: res.data}) );
	        });
        },

        showLoginDialog: function(){
            $('#loginModal').modal('show');
        },

        logout: function(){
            App.current_user_token = null;
            $('.loginUserName').hide();
            $(".linkToLogout").hide();
            $(".linkToLogin").show();
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
        },

        logoutClick: function(){
            $.ajax("/sessions/" + App.current_user_token, {
                method: 'DELETE',
                contentType: 'application/vnd.api+json'
            }).then(function(res) {
                App.logout();
            });

        },

        loginSubmit: function(){
            var self = this;
            App.current_user_name = $("#inputEmail").get(0).value;
            var attrs = {
                name: App.current_user_name,
                password: $("#inputPassword").get(0).value
            };
            $.ajax("/sessions", {
                method: 'POST',
                contentType: 'application/vnd.api+json',
                dataType: "json",
                data: JSON.stringify({
                    data: {
                        type: 'sessions',
                        attributes: attrs
                    }
                }),
                processData: false
            }).then(function(res) {
                App.current_user_token = res.data.attributes.token;
                $('.loginUserName').html(App.current_user_name);
                $('.loginUserName').show();
                $(".linkToLogout").show();
                $(".linkToLogin").hide();
                $('#loginModal').modal('hide');
            });
        }
    };

    App.init();
    App.refresh();
});
