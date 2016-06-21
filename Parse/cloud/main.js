Parse.Cloud.useMasterKey();

Parse.Cloud.define("phlash", function(request, response) {
		var parseFile = new Parse.File("file.png", request.params.fileData);

		var Phlash = Parse.Object.extend("Phlash");
   	var phlash = new Phlash();
		phlash.set("file", parseFile);
		phlash.set("caption", request.params.caption);
		phlash.set("yValue", request.params.yValue);
		phlash.set("username", Parse.User.current().getUsername());
		phlash.save(null, {
  			success: function(phlash) {
          // Parse.Push.send({
          //   channel: Parse.User.current().getUsername(),
          //   data: {
          //     alert: Parse.User.current().getUsername() + " has phlashed!",
          //     sound: "cheering.caf",
          //     badge: 1,
          //   }
          // });
				  response.success();
  			}, error: function(phlash, error) {
  			  response.error(error.code + " - " + error.message);
 				}
		});
});

Parse.Cloud.define("phollow", function(request, response) {

	var userQuery = new Parse.Query(Parse.User);
	userQuery.equalTo("username", request.params.toUsername);
	userQuery.count({
  	success: function(count) {
    	if (count >= 1) {
				var Phollow = Parse.Object.extend("Phollow");
				var phollowQuery = new Parse.Query(Phollow);
				phollowQuery.equalTo("fromUsername", Parse.User.current().getUsername());
				phollowQuery.equalTo("toUsername", request.params.toUsername);
				phollowQuery.count({
					success: function(count) {
		    		if (count >= 1) {
							response.error("Already following!");
						} else {
							var phollow = new Phollow();
						  phollow.set("fromUsername", Parse.User.current().getUsername());
							phollow.set("toUsername", request.params.toUsername);
						  phollow.save(null, {
						    success: function(phollow) {
						      // Parse.Push.send({
						      //   channel: request.params.toUsername,
						      //   data: {
						      //     alert: Parse.User.current().getUsername() + " started phollowing you!",
						      //     sound: "cheering.caf",
						      //     badge: 1,
						      //   }
						      // });
						      response.success();
						  		}, error: function(phollow, error) {
						  			response.error(error.code + " - " + error.message);
						 		  }
						    });
						}
					}, error: function(error) {
						response.error(error.code + " - " + error.message);
					}
				});
			} else {
				response.error("User doesn't exist");
			}
  	}, error: function(error) {
    	response.error(error.code + " - " + error.message);
  	}
	});
});


Parse.Cloud.define("unphollow", function(request, response) {
	var Phollow = Parse.Object.extend("Phollow");
  var phollowQuery = new Parse.Query(Phollow);
	phollowQuery.equalTo("fromUsername", Parse.User.current().getUsername());
	phollowQuery.equalTo("toUsername", request.params.toUsername);
	phollowQuery.first({
		success: function(object) {
			object.destroy({
  			success: function(object) {
	    		response.success();
  			}, error: function(object, error) {
    			response.error(error.code + " - " + error.message);
  			}
			});
		}, error: function(error) {
			response.error("You're not phollowing this user!");
		}
	});
});


Parse.Cloud.define("query", function(request, response) {
  var Phollow = Parse.Object.extend("Phollow");
  var Phlash = Parse.Object.extend("Phlash");

  var phollowQuery = new Parse.Query(Phollow);
  var phlashQuery = new Parse.Query(Phlash);

  phollowQuery.equalTo("fromUsername", Parse.User.current().getUsername());
	phollowQuery.greaterThan("createdAt", request.params.lastSeen);
  phlashQuery.matchesKeyInQuery("username", "toUsername", phollowQuery);
  phlashQuery.ascending("createdAt");

  phlashQuery.find({
    success: function(results) {
      response.success(results);
    }, error: function(error) {
      response.error(error.code + " - " + error.message);
    }
  });
});
