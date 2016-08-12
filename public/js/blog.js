$(function() {
    var indexedDB = window.indexedDB || window.webkitIndexedDB || window.mozIndexedDB || window.msIndexedDB;
    var App = {
        current_page: 1,
        template: null,
        current_user_token: null,
        current_user_name: null,

        init: function(){
            this.template = Hogan.compile($("#blogsArea").html());
            this.loginFromDb();
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

        setCurrentUserToken: function(token, keep){
            App.current_user_token = token;
            if (!token)
                App.current_user_name = null;
            if (keep) {
                App.storeToDB('current_session', {key: "user_name", value: App.current_user_name});
                App.storeToDB('current_session', {key: "token"    , value: App.current_user_token});
            }
        },

        showLoginDialog: function(){
            $('#loginModal').modal('show');
        },

        showToLogin: function(){
			$('.loginUserName').hide();
			$(".linkToLogout").hide();
			$(".linkToLogin").show();
        },

        showToLogout: function(){
            $('.loginUserName').html(App.current_user_name);
            $('.loginUserName').show();
            $(".linkToLogout").show();
            $(".linkToLogin").hide();
        },

        loginFromDb: function(){
            App.dbStore("current_session", function(store){
                var req1 = store.get("user_name")
                req1.onsuccess = function(){
                    if (req1.result)
                        App.current_user_name = req1.result.value;
                };
                var req2 = store.get("token")
                req2.onsuccess = function(){
                    if (req2.result) {
                        App.current_user_token = req2.result.value;
                    }
                    if (App.current_user_token) {
                        App.showToLogout();
                    } else {
                        App.showToLogin();
                    }
                };
            });
        },

        openDb: function(func){
            var func = arguments[0];
            if (indexedDB) {
                var openRequest = indexedDB.open("rails5_api_example3", 1);

                openRequest.onupgradeneeded = function(event) {
                    db = event.target.result;
                    db.createObjectStore("current_session", { keyPath: "key"});
                }

                openRequest.onerror = function (event) {
                    console.log(event);
                };

                openRequest.onsuccess = function(event) {
                    db = event.target.result;
                    //console.log(db);
                    func(db);
                }
            } else {
                window.alert("Indexed DataBase API isn't supported.");
            }
        },

        dbStore: function(storeName, func) {
            var storeName = arguments[0];
            var func = arguments[1];
            App.openDb(function(db){
                var transaction = db.transaction([storeName], "readwrite");
                var store = transaction.objectStore(storeName);
                //console.log(store);
                func(store);
            });
        },

        storeToDB: function(storeName, value) {
            App.dbStore("current_session", function(store){
                store.put(value);
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

        loginClick: function(){
            App.showLoginDialog();
        },

        logoutClick: function(){
            $.ajax("/sessions/" + App.current_user_token, {
                method: 'DELETE',
                contentType: 'application/vnd.api+json'
            }).then(function(res) {
                App.setCurrentUserToken(null, true);
                App.showToLogin();
            });

        },

        loginSubmit: function(){
            var self = this;
            App.current_user_name = $("#inputEmail").get(0).value;
            var keep = $("#checkRememberMe").get(0).checked;
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
                App.setCurrentUserToken(res.data.attributes.token, keep);
                App.showToLogout();
                $('#loginModal').modal('hide');
            });
        }
    };

    App.init();
    App.refresh();
});
