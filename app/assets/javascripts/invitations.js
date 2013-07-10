var SecretSantaInvites = {

    init:function(){
        this.setUpInviteesAddition();
    },

    setUpInviteesAddition: function(){
        $('#add_more_emails').click(function(){
            $('#invitees_list').append('<input id="invitees_" name="invitees[]" placeholder="email address" type="email"/>')
        })},

    setUpPartyReset :function(){
        return confirm("Are you sure you want to reset the party?");
    }

};

$(document).ready(function() {
    SecretSantaInvites.init();
});
