$(document).ready(function(){

  $("#principal_provincia_id").change(function() {
    var provincia_id = $("#principal_provincia_id").val()
    $.ajax({
      url: "/principals/obtener_region.js",
      dataType: "json",
      type: "GET",
      data: { provincia_id: provincia_id },
      contentType: "application/json",
      success:function(result){
        $("#region").val(result.detalle)
      },
      error: function(jqXHR, textStatus, errorThrown){
      }
    });
  });
});