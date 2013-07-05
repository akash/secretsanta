var SecretSantaExclusions = {

    init:function(){
        $('ul#excluded-users>li').tsort();
        $('ul#included-users>li').tsort();
        this.setUpDragging();
        this.setUpExcludedZone();
        this.setUpUnExcludedZone();
    },

    setUpDragging: function(){
        $('.draggable').each(function(){
            $(this).draggable({
                revert: "invalid"
            })
        });
    },

    setUpExcludedZone: function(){
        $("#droppable-excluded").droppable({
            accept: "#included-users .draggable",
            tolerance: "touch",
            drop: function( event, ui ) {
                SecretSantaExclusions.excludeUser( ui.draggable );
            }
        });
    },

    setUpUnExcludedZone: function(){
        $("#droppable-unexcluded").droppable({
            accept: "#excluded-users .draggable",
            tolerance: "fit",
            drop: function( event, ui ) {
                SecretSantaExclusions.includeUser( ui.draggable );
            }
        });
    },

    notifyExclusion: function (responseData) {
    },

    notifyInclusion: function (responseData) {

    },


    excludeUser: function(user){
        user.fadeOut(function() {
            var excludedUserId = user.attr('id');
            var partyId = $("#party-id").val();
            var userId = $("#user-id").val();
            $.post("/admin/parties/"+ partyId+"/users/"+userId+ "/exclude.json", {"excluded_user_id":excludedUserId}, SecretSantaExclusions.notifyExclusion, "JSON");

            var excludedUsers = $('#excluded-users')
            excludedUsers.append("<li class='draggable btn-inverse btn-large span10' id='"+user.attr('id')+"'>"+ user.html() + "</li>");
            SecretSantaExclusions.init();
        });
    },

    includeUser: function(user){
        user.fadeOut(function() {
            var includedUserId = user.attr('id');
            var partyId = $("#party-id").val();
            var userId = $("#user-id").val();
            $.post("/admin/parties/"+ partyId+"/users/"+userId+ "/include.json", {"included_user_id":includedUserId}, SecretSantaExclusions.notifyInclusion, "JSON");

            var includedUsers = $('#included-users')
            includedUsers.append("<li class='draggable btn-inverse btn-large span10' id='"+includedUserId+"'>"+ user.html() + "</li>");
            SecretSantaExclusions.init();
        });
    }

};

$(document).ready(function() {
    SecretSantaExclusions.init();
});
