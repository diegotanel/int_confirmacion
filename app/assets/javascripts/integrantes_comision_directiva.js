// Generated by CoffeeScript 1.6.2
(function() {
  jQuery(function() {
    var localidades, llenarLocalidades;

    llenarLocalidades = function(localidades) {
      var provincia, options;

      provincia = $('#ideec_provincia_id :selected').text();
      options = $(localidades).filter("optgroup[label='" + provincia + "']").html();
      if (options) {
        $("#integrante_comision_directiva_localidad_id").html('<option value="">Seleccione una localidad...</option>');
        return $("#integrante_comision_directiva_localidad_id").append(options);
      } else {
        return $("#integrante_comision_directiva_localidad_id").empty();
      }
    };
    localidades = $("#integrante_comision_directiva_localidad_id").html();
    llenarLocalidades(localidades);
    return $('#ideec_provincia_id').change(function() {
      return llenarLocalidades(localidades);
    });
  });

}).call(this);