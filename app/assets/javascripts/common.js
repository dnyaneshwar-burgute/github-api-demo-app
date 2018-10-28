$(document).ready(function(){
  setTimeout(function() {
    $('.alert').fadeOut('slow');}, 3000
  );
  $( "#public_repos" ).accordion({header: "h3", collapsible: true, active: false});
  $( "#private_repos" ).accordion({header: "h3", collapsible: true, active: false});
})
