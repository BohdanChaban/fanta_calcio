$(document).on('turbolinks:load', function() {
    $('#squad_approve_btn input').attr('class', 'btn btn-primary');

    $('.main_form .member-container').hide();

    var formation, df, mf, fw;
    $( '.form_block_input' ).click(function() {
        $('.main_form .member-container').hide();

        $('.member-container select').val('');
        $('.image-container').css('background-image', '');

        formation = $('select#formation')[0].value;
        df = parseInt(formation.charAt(0));
        mf = parseInt(formation.charAt(1));
        fw = parseInt(formation.charAt(2));

        $('.gk .member-container').show();

        for (var i = 0; i < df; i++) {
            $($('.df .member-container')[i]).show();
        }

        for (var i = 0; i < mf; i++) {
            $($('.mf .member-container')[i]).show();

        }

        for (var i = 0; i < fw; i++) {
            $($('.fw .member-container')[i]).show();

        }
    });

    $(document).on('click','.member-container select', function () {
        var player_id = this.value;
        var image_container = $(this).parent().children('div');

        // $(".member-container select option[value="+player_id+"]").remove();

        $.ajax({
            type: 'GET',
            dataType: 'json',
            url: '/players/'+player_id,
            success: function(data){
                var player = data;
                image_container.css('background-image', 'url('+player.avatar+')');
            }
        });
    });
});
