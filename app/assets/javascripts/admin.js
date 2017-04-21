function defer(method) {
    if (window.jQuery)
        method();
    else
        setTimeout(function() { defer(method) }, 50);
};


$('#accordion-form').accordion();

var admin_accordion = $("#accordion");

if(admin_accordion.length){
  admin_accordion.accordion({heightStyle: "content"});
  $('#admin-panel').fadeIn();
}


$('#toggle-client-view').click(function(){
    console.log("button clicked");

  // hide all admin panels
  $(".admin").each(function(index, el){
    $(el).fadeToggle();
  });

  //
  var mainContainer = $("#main-container");
  var offsetClasses = 'col-lg-offset-2 col-md-offset-1';
  if(mainContainer.hasClass(offsetClasses)){
    $(this).text('Afficher la vue client');
    $("#main-container").removeClass(offsetClasses);
  }else{
    $(this).text("Afficher l'administration");
    $("#main-container").addClass(offsetClasses);
  }
});