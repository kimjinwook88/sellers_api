/*
	jQuery autoComplete v1.0.7
    Copyright (c) 2014 Simon Steinberger / Pixabay
    GitHub: https://github.com/Pixabay/jQuery-autoComplete
	License: http://www.opensource.org/licenses/mit-license.php
*/
(function($){
    $.fn.autoComplete = function(options){
        var o = $.extend({}, $.fn.autoComplete.defaults, options);

        // public methods
        if (typeof options == 'string') {
            this.each(function(){
                var that = $(this);
                if (options == 'destroy') {
                    $(window).off('resize.autocomplete', that.updateSC);
                    that.off('blur.autocomplete Ffocus.autocomplete keydown.autocomplete keyup.autocomplete');
                    if (that.data('autocomplete'))
                        that.attr('autocomplete', that.data('autocomplete'));
                    else
                        that.removeAttr('autocomplete');
                    $(that.data('sc')).remove();
                    that.removeData('sc').removeData('autocomplete');
                }
            });
            return this;
        }

        return this.each(function(){
            var that = $(this);
            // sc = 'suggestions container'
            that.sc = $('<div class="autocomplete-suggestions '+o.menuClass+'"></div>');
            that.data('sc', that.sc).data('autocomplete', that.attr('autocomplete'));
            that.cache = {};
            that.last_val = '';
            
            that.updateSC = function(resize, next){
            	
            	// 화면크기 변경될 때 회색 선 생기는 현상 막음
            	if(resize){
//            		if(!$('.autocomplete-suggestions')[0].childElementCount){
//                		$('.autocomplete-suggestions').hide();
//                	}
            	}            	
            	
            	if(resize == 1){
            		that.sc.css({
                        //top: that.offset().top + that.outerHeight(),
                        //left: that.offset().left,
                        width: that.outerWidth()+160
                    });
            		that.sc.show();
            	}else{
            		that.sc.css({
                        //top: that.offset().top + that.outerHeight(),
                        //left: that.offset().left,
                        width: that.outerWidth() + (o.wd != undefined) ? o.wd : 0
                    });
            		that.sc.show();
            	}
            	
                if (!resize) {
                    that.sc.show();
                    if (!that.sc.maxHeight) that.sc.maxHeight = parseInt(that.sc.css('max-height'));
                    if (!that.sc.suggestionHeight) that.sc.suggestionHeight = $('.autocomplete-suggestion', that.sc).first().outerHeight();
                    if (that.sc.suggestionHeight)
                        if (!next) that.sc.scrollTop(0);
                        else {
                            var scrTop = that.sc.scrollTop(), selTop = next.offset().top - that.sc.offset().top;
                            if (selTop + that.sc.suggestionHeight - that.sc.maxHeight > 0)
                                that.sc.scrollTop(selTop + that.sc.suggestionHeight + scrTop - that.sc.maxHeight);
                            else if (selTop < 0)
                                that.sc.scrollTop(selTop + scrTop);
                        }
                }
            }
            //$(window).on('resize.autocomplete', that.updateSC);
            
            that.sc.appendTo($(this).parent('.pos-rel'));

            that.sc.on('mouseleave', '.autocomplete-suggestion', function (){
                $('.autocomplete-suggestion.selected').removeClass('selected');
            });

            that.sc.on('mouseenter', '.autocomplete-suggestion', function (){
                $('.autocomplete-suggestion.selected').removeClass('selected');
                $(this).addClass('selected');
            });

            that.sc.on('mousedown click', '.autocomplete-suggestion', function (e){
                var item = $(this), v = item.data('val');
                if (v || item.hasClass('autocomplete-suggestion')) { // else outside click
                    that.val(v);
                    o.onSelect(e, v, item);
                    that.sc.hide();
                    // select 제거
                	$('.autocomplete-suggestion').removeClass('selected');
                }
                return false;
            });

            that.on('blur.autocomplete', function(){
            	
            	// select 제거
            	$('.autocomplete-suggestion').removeClass('selected');
            	
                try { over_sb = $('.autocomplete-suggestions:hover').length; } catch(e){ over_sb = 0; } // IE7 fix :hover
                if (!over_sb) {
                    that.last_val = that.val();
                    that.sc.hide();
                    // select 제거
                	$('.autocomplete-suggestion').removeClass('selected');
                    setTimeout(function(){ that.sc.hide(); }, 350); // hide suggestions on fast input
                } else if (!that.is(':focus')) setTimeout(function(){ that.focus(); }, 20);
            });

            if (!o.minChars) that.on('focus.autocomplete', function(){ that.last_val = '\n'; that.trigger('keyup.autocomplete'); });

            function suggest(data, searchVal){
            	
            	// 아래방향키 클릭 시, 목록 사라지는 현상 막기 위함
            	if($('.autocomplete-suggestion').hasClass('selected')){
            		return false;
            	}
            	
            	// 검색어와 조회 결과 다를 경우 return
            	if(searchVal && (searchVal != that.last_val)){
            		return;
            	}
            	
            	var val = that.val();
                that.cache[val] = data;
                if (data.length && val.length >= o.minChars) {
                    var s = '';
                    for (var i=0;i<data.length;i++) s += o.renderItem(data[i], val);
                    that.sc.html(s);
                    that.updateSC(0);
                }
                else{
                	//that.sc.html('<div class="word_blank">데이터가 없습니다.<br /><a href="'+o.emptyUrl+'" class="">'+o.emptyMsg+' 등록하기</a></div>');
                	if( o.emptyUrl != null && o.emptyUrl.trim != "" ){
                		that.sc.html('<div class="word_blank"><span class="ment">등록된 '+o.emptyMsg+'(이)가 없습니다.</span><a href="'+o.emptyUrl+'" class="" target="_blank">'+o.emptyMsg+' 등록</a></div>');
                	}else{
                		that.sc.html('<div class="word_blank"><span class="ment">등록된 '+o.emptyMsg+'(이)가 없습니다.</span></div>');
                	} 
                	that.updateSC(1);
                }
            }

            that.on('keydown.autocomplete', function(e){
            	// down (40), up (38)
            	if ((e.which == 40 || e.which == 38) && that.sc.html()) {
                	                	
                	// 입력된 텍스트가 없는 경우
                	if(that.val() == null || that.val() == undefined || that.val() == ""){
                		return false;
                	}
                	
                    var next, sel = $('.autocomplete-suggestion.selected', that.sc);
                    if (!sel.length) {
                        next = (e.which == 40) ? $('.autocomplete-suggestion', that.sc).first() : $('.autocomplete-suggestion', that.sc).last();
                        that.val(next.addClass('selected').data('val'));
                    } else {
                        next = (e.which == 40) ? sel.next('.autocomplete-suggestion') : sel.prev('.autocomplete-suggestion');
                        if (next.length) { sel.removeClass('selected'); that.val(next.addClass('selected').data('val')); }
                        else { sel.removeClass('selected'); that.val(that.last_val); next = 0; }
                    }
                    that.updateSC(0, next);
                    return false;
                }
                // esc
                else if (e.which == 27) {that.val(that.last_val).sc.hide(); 
                	// select 제거
            		$('.autocomplete-suggestion').removeClass('selected');
            	}
                // enter or tab
                else if (e.which == 13 || e.which == 9) {
                    var sel = $('.autocomplete-suggestion.selected', that.sc);
                    if (sel.length && that.sc.is(':visible')) { o.onSelect(e, sel.data('val'), sel); setTimeout(function(){ that.sc.hide(); }, 20); }
                }
            });

            that.on('keyup.autocomplete', function(e){
                if (!~$.inArray(e.which, [13, 27, 35, 36, 37, 38, 39, 40])) {
                    var val = that.val();
                    if (val.length >= o.minChars) {
                        if (val != that.last_val) {
                            that.last_val = val;
                            clearTimeout(that.timer);
                            if (o.cache) {
                                if (val in that.cache) { suggest(that.cache[val]); return; }
                                // no requests if previous suggestions were empty
                                for (var i=1; i<val.length-o.minChars; i++) {
                                    var part = val.slice(0, val.length-i);
                                    if (part in that.cache && !that.cache[part].length) { suggest([]); return; }
                                }
                            }
                            that.timer = setTimeout(function(){ o.source(val, suggest) }, o.delay);
                        }
                    } else {
                        that.last_val = val;
                        that.sc.hide();
                        // select 제거
                    	$('.autocomplete-suggestion').removeClass('selected');
                    }
                }else if(e.which == 40 && that.val()){
                	var val = that.val();
                    if (val.length >= o.minChars) {
//                        if (val != that.last_val) {
                            that.last_val = val;
                            clearTimeout(that.timer);
                            if (o.cache) {
                                if (val in that.cache) { suggest(that.cache[val]); return; }
                                // no requests if previous suggestions were empty
                                for (var i=1; i<val.length-o.minChars; i++) {
                                    var part = val.slice(0, val.length-i);
                                    if (part in that.cache && !that.cache[part].length) { suggest([]); return; }
                                }
                            }
                            that.timer = setTimeout(function(){ o.source(val, suggest) }, o.delay);
//                        }
                    } else {
                        that.last_val = val;
                        that.sc.hide();
                        // select 제거
                    	$('.autocomplete-suggestion').removeClass('selected');
                    }
                }
            });
        });
    }
    
    $.fn.autoComplete.defaults = {
        source: 0,
        minChars: 3,
        delay: 150,
        cache: 0,
        menuClass: '',
        emptyUrl : null,
        emptyMsg : null,
        renderItem: function (item, search){
        	
            // escape special characters
            search = search.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&');
            var re = new RegExp("(" + search.split(' ').join('|') + ")", "gi");
            
            if(item.type == "singleClientIndividual"){
            	var position ='';
            	var email = '';
            	if(!isEmpty(item.position)){
            		position = ' ['+item.position+']';
            	}
            	if(!isEmpty(item.email)){
            		email = ' ['+item.email+']';
            	}
            	return' <div class="autocomplete-suggestion" data-val="' + item.label + '" hidden-data="'+ item.value + '" hidden-position="' + item.position + '" hidden-calendarId="' + item.calendarId + '" hidden-email="' + item.email + '">'+(item.label).replace(re, "<b>$1</b>")+position+email+'</div>';
            }
            
            else if(item.type == "multiClientIndividual"){
            	var position = '';
            	if(!isEmpty(item.position)){
            		position = ' ['+item.position+']';
            	}
            	return' <div class="autocomplete-suggestion" data-val="' + item.label + '" hidden-data="'+ item.value + '" hidden-position="' + item.position + '" hidden-calendarId="' + item.calendarId + '" hidden-email="' + item.email + '">'+(item.label).replace(re, "<b>$1</b>")+' '+item.calendarId+position+'</div>';
            }
            
            else if(item.type == "singleProduct"){
            	return' <div class="autocomplete-suggestion" title="' + item.label + '" data-val="' + item.label + '" hidden-data="'+ item.value + '" hidden-position="' + item.position + '" hidden-st="' + item.st + '">'+'['+(item.value).replace(re, "<b>$1</b>")+']'+' <br /> '+ (item.label).replace(re, "<b>$1</b>") +'</div>';
            }
            
            else if(item.type == "singleCompany"){
            	return' <div class="autocomplete-suggestion" data-val="' + item.label + '" hidden-data="'+ item.value + '" hidden-position="' + item.position + '">'+(item.label).replace(re, "<b>$1</b>") +'</div>';
            }
            
            else if(item.type == "singleMember"){
            	var position = '';
            	if(!isEmpty(item.position)){
            		position = ' ['+item.position+']';
            	}
            	return' <div class="autocomplete-suggestion" data-val="' + item.label + '" hidden-data="'+ item.value + '" hidden-erpcd="'+ item.erpcd + '" hidden-position="' + item.position + '" >'+(item.label).replace(re, "<b>$1</b>") + position +'</div>';
            }
            
            else if(isEmpty(item.position) || item.position == "undefined"){
            	return '<div class="autocomplete-suggestion" data-val="' + item.label + '" hidden-data="'+ item.value + '" hidden-position="' + item.position + '" hidden-calendarId="' + item.calendarId + '" hidden-email="' + item.email + '">'+(item.label).replace(re, "<b>$1</b>")+'</div>';
            }
            
            else{
            	return' <div class="autocomplete-suggestion" data-val="' + item.label + '" hidden-data="'+ item.value + '" hidden-position="' + item.position + '" hidden-calendarId="' + item.calendarId + '" hidden-email="' + item.email + '">'+(item.label).replace(re, "<b>$1</b>")+' '+'['+item.position+']'+'</div>';	
            }
        },
        onSelect: function(e, term, item){}
    };
    
/*    $.fn.autoCompleteEmpty = function(){
    	var that = $(this);
    	var thatParent = that.parent('div.pos-rel');
    	that.sc = $('<div class="autocomplete-suggestions">dddddddd</div>');
         that.sc.css({
             width: that.outerWidth()
         });
         thatParent.append(that.sc);
    }
*/    
}(jQuery));
