#encoding: utf-8
FactoryGirl.define do
  factory :user do
    name     "Michael"
    last_name "Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :formulario do
    id 1
    user
    estado 2
  end

  factory :principal do
    localidad
    grupo
    nombre "Los Chaquenos"
    formulario
  end

  factory :provincia do
    id 1
    detalle "Buenos Aires"
    codigo "aa"
    region
  end

  factory :region do
    id 1
    codigo "1800"
    detalle "Centro"
  end

  factory :localidad do
    id 1
    detalle "Capital Federal"
    codigo "bb"
    provincia
  end

  factory :grupo do
    id 1
    codigo "G"
    detalle "Grupo"
  end

  factory :elenco_en_gira do
    id 1
    formulario
  end

  factory :datos_grupo do
    nombre_grupo     "Michael Hartl"
    historia    "asdadfasdfsdfsfdgfagafsdgafdgadfgdfagdafgdfagdfagafdgdfagdfgdfagadsfgdfagdfg"
    formulario
  end

  factory :datos_tec do
    duracion_montaje "10"
    duracion_desmontaje "10"
    descripcion_espacio "desc"
    ancho "23"
    alto "11"
    profundidad "20"
    listado_artefactos_luminicos "adsfa"
    listado_sonido "asdfasd"
    peso_total "122"
    volumen_total "31"
    formulario
    esps_esps
  end

  factory :datos_esp do
    formulario
    fecha_de_estreno DateTime.now
    nombre_autor "asdfa"
    nacionalidad_autor "fasd"
    duracion_espectaculo "12345"
    sinopsis_obra "adfas"
  end

  factory :persona_fisica_e do
    integrante_de_elenco_en_gira
    responsable
  end

  factory :responsable do
    formulario
  end

  factory :integrante_de_elenco_en_gira do
    type "Actor"
    nombre "Jorge"
    apellido "Gomez"
    cuil_cuit "12345678901"
    fecha_de_nacimiento DateTime.now
    calle "Corrientes"
    altura_calle "5200"
    localidad
    codigo_postal "1414"
    tel_celular "123144123"
    email "d@d.com"
    elenco_en_gira
  end

  factory :esps_esps do
    detalle "asdfas"
  end

end
