var SecretSantaInvites = {

    init:function(){
        this.setUpInviteesAddition();
    },

    setUpInviteesAddition: function(){
        $('#add_more_emails').click(function(){
            $('#invitees_list').append('<label for="invitees_">email address: </label><input id="invitees_" name="invitees[]" type="text"/>')
        });
    }

};

$(document).ready(function() {
    SecretSantaInvites.init();
});