

  $(document).ready(function(){
    $('#datos_esp_fecha_de_estreno').datepicker({
      format: "dd/mm/yyyy",
      todayHighlight: true,
      todayBtn: 'linked',
      autoclose: true,
      language: "es",
      changeMonth: true,
      changeYear: true,
      yearRange: '1900:2020'
    });
  });