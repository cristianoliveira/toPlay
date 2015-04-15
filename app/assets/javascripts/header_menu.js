$(document).on("click", '.menu-item li>a', function(){

  var url = $(this).attr('data-url');
  var parent = $(this).parent().parent();
  var update = parent.attr('data-update');
  var menu = $(update+' ul.dropdown-menu');

  if(!update)
  {
    window.location.assign(url)
  }
  else
  {
    if(!$(update).hasClass('hidden'))
      $(update).addClass('hidden')

    menu.empty();

    $.ajax({
        type: "GET",
        url: url,
        success: function(result){
            var rows = result.result;
            $.each(rows, function(id, data)
            {
                $(update).removeClass('hidden')
                menu.append('<li role="presentation">'
                             +'<a class="dropdown-menu-item'
                                   +' href="'+data.url+'"'
                                   +' id="'+data.value.id+'"'
                                   +' data-url="'+data.url+'">'+
                                   data.value.name+
                               '</a></li>')
            });
        }
    });
  }
});

$(".enter-to-click").mouseenter(function(event){
  $(this).click();
})
