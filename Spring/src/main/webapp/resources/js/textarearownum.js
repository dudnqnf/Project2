jQuery.fn.trackRows = function() {
    return this.each(function() {

        var ininitalHeight, currentRow, firstIteration = true;

        var createMirror = function(textarea, orgId) {
            jQuery(textarea).after('<div id="'+orgId+'-mirror"></div>');
            return jQuery(textarea).next('#'+orgId+'-mirror')[0];
        }

        var sendContentToMirror = function (textarea) {
            mirror.style.padding = jQuery(textarea).css('padding');
            mirror.style.width = jQuery(textarea).css('width');
            mirror.style.fontFamily = jQuery(textarea).css('font-family');
            mirror.style.fontSize = jQuery(textarea).css('font-size');
            mirror.style.lineHeight = jQuery(textarea).css('line-height');
            mirror.innerHTML = String(textarea.value.substring(0,textarea.selectionStart)).replace(/&/g, '&amp;').replace(/"/g, '&quot;').replace(/'/g, '&#39;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/\n/g, '<br />') + '.<br/>.';
            calculateRowNumber();
        }

        var growTextarea = function () {
            sendContentToMirror(this);
        }

        var calculateRowNumber = function () {
            if(firstIteration){
                ininitalHeight = $(mirror).height();
                currentHeight = ininitalHeight;
                firstIteration = false;
            } else {
                currentHeight = $(mirror).height();
            }
            // Assume that textarea.rows = 2 initially
            currentRow = currentHeight/(ininitalHeight) - 1;
            //remove tracker in production
            //alert(currentRow);
            $("#"+$(mirror).attr('id')+"-value").val(currentHeight-ininitalHeight);
        }

        // Create a mirror
        var mirror = createMirror(this, $(this).attr('id'));

        // Style the mirror
        mirror.style.display = 'none';
        mirror.style.wordWrap = 'break-word';
        mirror.style.whiteSpace = 'normal';
        mirror.style.padding = jQuery(this).css('padding');
        mirror.style.width = jQuery(this).css('width');
        mirror.style.fontFamily = jQuery(this).css('font-family');
        mirror.style.fontSize = jQuery(this).css('font-size');
        mirror.style.lineHeight = jQuery(this).css('line-height');

        // Style the textarea
        this.style.overflow = "hidden";
        this.style.minHeight = this.rows+"em";

        var ininitalHeight = $(mirror).height();

        // Bind the textarea's event
        this.onkeyup = growTextarea;

        // Fire the event for text already present
        // sendContentToMirror(this);

    });
};