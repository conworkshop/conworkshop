var app = window.app = {}
app.Wordlinks = function() {
    this._input = $('#autoWordlink')
    this._initAutocomplete();
};

app.Wordlinks.prototype = {
    _initAutocomplete: function() {
        this._input
            .autocomplete({
                //source: '/wordlinks',
                source: '/wordlinks',
                select: $.proxy(this._select, this),
                close: $.proxy(this._onclose, this)
            })
            .autocomplete('instance')._renderItem = $.proxy(this._render, this);
    },

    _select: function(e, ui) {
        if(ui.item.reg == true) {
            $('#wlTempWLID').val(ui.item.wlid);
            $('#wlTempEnglish').val(ui.item.english);
            $('#wlTempHint').val(ui.item.hint);
            $('#wlModalEnglish').html(ui.item.english);
            $('#wlModalHint').html('('+ui.item.hint+')');
            beginAddword();
        } else {
            e.preventDefault();
        }
        return false;
    },

    _onclose: function (event, ui) {
        if (!$("ul.ui-autocomplete").is(":visible")) {
            if(this._input.val() != '') {
                $("ul.ui-autocomplete").show();
            }
        }
    },

    _render: function(ul, item) {
        if (item.reg == true) {
            return $('<li>')
                .append(item.english + ' <small>' + item.wc + ' · ' + item.hint + '</small>')
                .appendTo(ul);
        } else {
            return $('<li class="nopick">')
                .append(item.english)
                .appendTo(ul);
        }
    }
};

$(document).ready(function(){
    init_wl_dropdown();
    document.addEventListener("turbolinks:load", init_wl_dropdown);
});

function init_wl_dropdown() {
    if($("body").hasClass("words new")) {
        new app.Wordlinks;

        $('#btnAddDef').click(function () {
            var action = $('#wlFormAction').val();
            if (action == 'def') {
                add_wl_default_options();
            }
            clear_autocomplete();
            $('#wlAddModal').modal('hide');
        });
    }
}

function beginAddword(){
    if ($('#wlHiddenFields input.wlMainVal').length > 0) {
        $('#wlAddModal').modal('show')
    } else {
        add_wl_default_options();
        clear_autocomplete();
    }
}

function clear_autocomplete(){
    $('#autoWordlink').val('');
    $('#wlFormRegister').val('N');
    $('ul.ui-autocomplete').hide();
}

function add_wl_default_options(){
    addWordlink($('#wlTempWLID').val(), $('#wlTempEnglish').val(), $('#wlTempHint').val(), $('#wlFormRegister').val(), $('#wlFormRegister option:selected').text());
}

function addWordlink(wlid, english, hint, reg, reg_s){
    $('.wlDefPretext').remove();
    var c = $('#wlHiddenFields input.wlMainVal').length;
    $('#wlHiddenFields')
        .append('<input type="hidden" class="wlMainVal" name="word[wordlinks]['+c+'][wlids][]" value="'+wlid+'" />')
        .append('<input type="hidden" class="wlMainReg" name="word[wordlinks]['+c+'][register]" value="'+reg+'" />');
    var q;
    if (reg == 'N') {
        q = '';
    } else {
        q = '(<i>' + reg_s.toLowerCase() + '</i>) ';
    }
    $('#wlDefinitions')
        .append('<li class="my-1"><div>'+q+english+' <span class="text-muted">('+hint+')</span> <button id="wlBtnDel-'+c+'-0" class="small inline-minicircle bg-danger text-white wlRemDef">&times;</button></div></li>')
}