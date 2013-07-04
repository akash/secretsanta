var SecretSantaExclusions = {

    init:function(){
        var unexcludedZone = $( "#droppable-unexcluded" );
        var excludedZone = $( "#droppable-excluded" );
        this.setUpExclusions();
        this.setUpExcludedZone();
        this.setUpUnExcludedZone();
    },

    setUpExclusions: function(){
        $('.draggable').each(function(){
            $(this).draggable({
                revert: "invalid"
            })
        });
    },

    setUpExcludedZone: function(){
        $("#droppable-excluded").droppable({
            accept: ".included-users .draggable",
            tolerance: "fit",
            drop: function( event, ui ) {
                SecretSantaExclusions.excludeUser( ui.draggable );
            }
        });
    },

    setUpUnExcludedZone: function(){
        $("#droppable-unexcluded").droppable({
            accept: ".excluded-users .draggable",
            tolerance: "fit",
            drop: function( event, ui ) {
                SecretSantaExclusions.includeUser( ui.draggable );
            }
        });
    },

    excludeUser: function(user){
        alert("excluding");
        user.fadeOut(function() {
//            var $list = $( "ul", $trash ).length ?
//                $( "ul", $trash ) :
//                $( "<ul class='gallery ui-helper-reset'/>" ).appendTo( $trash );
//
//            user.find( "a.ui-icon-trash" ).remove();
//            user.append( recycle_icon ).appendTo( $list ).fadeIn(function() {
//                user
//                    .animate({ width: "48px" })
//                    .find( "img" )
//                    .animate({ height: "36px" });
//            });
        });
    },

    includeUser: function(user){
        alert("including");
    }

};

$(document).ready(function() {
    SecretSantaExclusions.init();
});
