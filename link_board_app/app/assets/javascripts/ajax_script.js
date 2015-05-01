$(function(){
    console.log("ajax loaded");

    $('form.new_vote').submit(function(e) {
        e.preventDefault();
        $.post($(this).attr('action')+'.json',$(this).serialize()).done(function(data) {
            console.log(data);
            var voteCount = $('#'+data.id+'-votes')
            voteCount.text(data.votes);
            if (data.type == 0) {
                $('#'+data.id+'-upvote').removeClass('btn-success').removeClass('voted').addClass('btn-default');
                $('#'+data.id+'-downvote').removeClass('btn-danger').removeClass('voted').addClass('btn-default');
            } else if (data.type == 1) {
                $('#'+data.id+'-upvote').removeClass('btn-default').addClass('voted').addClass('btn-success');
                $('#'+data.id+'-downvote').removeClass('btn-danger').removeClass('voted').addClass('btn-default');
            } else if (data.type == -1) {
                $('#'+data.id+'-upvote').removeClass('btn-success').removeClass('voted').addClass('btn-default');
                $('#'+data.id+'-downvote').removeClass('btn-default').addClass('voted').addClass('btn-danger');
            }
        });
    });

});