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
end
