/*
 Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function (config) {
    config.PreserveSessionOnFileBrowser = true;
    // Define changes to default configuration here. For example:
    //config.language = 'he';
    // config.uiColor = '#AADC6E';

    //config.ContextMenu = ['Generic','Anchor','Flash','Select','Textarea','Checkbox','Radio','TextField','HiddenField','ImageButton','Button','BulletedList','NumberedList','Table','Form'] ;

    config.height = '300px';
    config.width = '300px';

    //config.resize_enabled = false;
    //config.resize_maxHeight = 2000;
    //config.resize_maxWidth = 750;

    //config.startupFocus = true;

    // works only with en, ru, uk languages
    //config.extraPlugins = "embed,attachment,MediaEmbed";
    config.toolbar = 'Plus';


    config.toolbar_Plus =
        [
            ['Bold', 'Italic', 'Underline'],
            ['Link', 'Unlink'],
            ['Maximize', 'Source'],
            ['RemoveFormat', 'Format', 'FontSize'],
            ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord'],
            ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-', 'BidiLtr', 'BidiRtl']


//        ZZ['Source','-','Preview','Templates'], ['TextColor'],
//        [,'About']
//        ['-','Subscript','Superscript'],
//        ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
//        ['Link','Unlink','Anchor'],
//        ['Image','Embed','Flash','Attachment','Table','HorizontalRule','Smiley','SpecialChar','PageBreak']
    ];
};

CKEDITOR.on('dialogDefinition', function (ev) {
    // Take the dialog name and its definition from the event data.
    var dialogName = ev.data.name;
    var dialogDefinition = ev.data.definition;

    // Check if the definition is from the dialog we're
    // interested in (the 'link' dialog).
    if (dialogName == 'link') {
        // Remove the 'Target' and 'Advanced' tabs from the 'Link' dialog.
//         dialogDefinition.removeContents( 'target' );
        dialogDefinition.removeContents('advanced');
        dialogDefinition.removeContents('upload');

        // Get a reference to the 'Link Info' tab.
        var infoTab = dialogDefinition.getContents('info');

        // Remove unnecessary widgets from the 'Link Info' tab.
//         infoTab.remove( 'linkType');
        infoTab.remove('browse');
        infoTab.remove('protocol');
    }
});