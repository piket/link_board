$(function() {

    $('.help-block').hide();

    var checkTitleLength = function() {
        var wrapper = $(this).parent('div')
        if($(this).val().length < 20) {
            if(wrapper.hasClass('has-default') || wrapper.hasClass('has-success')) {
                wrapper.removeClass('has-default').removeClass('has-success');
                wrapper.addClass('has-error');
                $(this).on('keydown',checkTitleLength);
            }
        } else {
            wrapper.removeClass('has-default').removeClass('has-error');
            wrapper.addClass('has-success');
        }
    }

    $('#post_title').on('blur', checkTitleLength);
    $('#post_link').on('focus', function() {
        if ($(this).val() === "") $(this).val('http://');
    });
    $('#post_link').on('paste', function(e) {
        if($(this).val() === 'http://') $(this).val('').val(e.target.value);
    });
    $('#post_link').on('blur',function(){
        if($(this).val() === 'http://' || $(this).val() === 'https://') $(this).val('');
    });

    var checkInputField = function(field) {
        wrapper = $(field).parent('div')
        if($(field).val() === '') {
            wrapper.addClass('has-error').removeClass('has-default').removeClass('has-success');
            wrapper.children('.help-block').show();
            return true;
        } else {
            wrapper.addClass('has-success').removeClass('has-default').removeClass('has-error');
            wrapper.children('.help-block').hide();
            if($(field).attr('id') === 'user_email' && $(field).val().match(/^[\w\.=-]+@[\w\.-]+\.[\w]{2,3}$/g) === null) {
                wrapper.children('.help-block').show();
                wrapper.addClass('has-error').removeClass('has-success');
                return true;
            } else if ($(field).attr('id') === 'user_name' && $(field).val().length > 20) {
                wrapper.children('.help-block').show();
                wrapper.addClass('has-error').removeClass('has-success');
                return true;
            } else if ($(field).attr('id') === 'user_password_confirmation' && $(field).val() !== $('#user_password').val()) {
                wrapper.children('.help-block').show();
                wrapper.addClass('has-error').removeClass('has-success');
                var sibWrapper = $('#user_password').parent('div');
                sibWrapper.addClass('has-error').removeClass('has-success').removeClass('has-default');
                return true;
            }
        }
        return false;
    }

    $('.user-form>input').on('blur',function(e) {
        checkInputField(e.target);
    });

    $('form').submit(function(e) {
        var inputArr = $(this).children('.user-form');
        for (var i = 0; i < inputArr.length; i++) {
            if (checkInputField($(inputArr[i]).children('input'))) {
                e.preventDefault();
            }
        }
    });

    $('form').on('reset',function() {
        $('.help-block').hide();
        var inputArr = $(this).children('.user-form')
        for (var i = 0; i < inputArr.length; i++) {
            $(inputArr[i]).removeClass('has-success').removeClass('has-error').addClass('has-default');
        }
    });
});