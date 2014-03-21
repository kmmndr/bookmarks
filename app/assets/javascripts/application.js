// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery.fileupload
//= require_tree .

$(document).ready(function () {
  //disable Click event for links, replace with 'goto' link
  $("a[data-goto]").click( function(e) {
    var goto_url = $(this).attr('data-goto');
    $(this).target = "_blank";
    window.open(goto_url);
    return false;
  });

  $('#basic').fileupload({
    done: function(e, data) {
      console.log("Done", data.result);
      //return $("body").append(data.result);
    }
  });
});
