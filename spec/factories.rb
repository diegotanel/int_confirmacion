#encoding: utf-8
FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
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
    provincia
    localidad
    grupo
    registro
    nombre "Los Chaquenos"
    formulario
  end

  factory :provincia do
    id 1
    detalle "Buenos Aires"
    region
  end

  factory :region do
    id 1
    detalle "Centro"
  end

  factory :localidad do
    id 1
    detalle "Capital Federal"
  end

  factory :grupo do
    id 1
    detalle "Grupo"
  end

  factory :condicion do
    codigo "ic2014"
    detalle "Espectáculo Integrante Catálogo 2014"
  end

  factory :registro do
    numero_de_registro "1234567890"
    detalle "Ya registrado"
  end

  factory :elencos_en_gira do
    id 1
    formulario
  end

  factory :actor do
    id 1
    elencos_en_gira
    nombre_actor "Pedro"
    apellido_actor "Gomez"
    num_de_cuil_cuit "12345678912"
    fecha_de_nacimiento 1/1/2000
    calle "Santa fe"
    altura_calle "1000"
    actor_provincia "Buenos Aires"
    actor_localidad "Capital Federal"
    codigo_postal "1406"
    email "pedro.gomez@gmail.com"
  end

  factory :tecnico do
    id 1
    elencos_en_gira
    nombre_actor "Hernan"
    apellido_actor "Gomez"
    num_de_cuil_cuit "12345678912"
    fecha_de_nacimiento 1/1/1999
    calle "Santa fe"
    altura_calle "2000"
    actor_provincia "Buenos Aires"
    actor_localidad "Capital Federal"
    codigo_postal "1406"
    email "hernan.gomez@gmail.com"
  end

  factory :director do
    id 1
    elencos_en_gira
    nombre_actor "Juan"
    apellido_actor "Gomez"
    num_de_cuil_cuit "12345678912"
    fecha_de_nacimiento 1/1/1998
    calle "Santa fe"
    altura_calle "3000"
    actor_provincia "Buenos Aires"
    actor_localidad "Capital Federal"
    codigo_postal "1406"
    email "juan.gomez@gmail.com"
  end
end
