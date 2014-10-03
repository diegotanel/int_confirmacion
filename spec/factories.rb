FactoryGirl.define do
  factory :user do
    name     "Michael Hartl"
    email    "michael@example.com"
    password "foobar"
    password_confirmation "foobar"
  end

  factory :formulario do
  	content "hola pepito"
  	user
  end

  factory :principal do
    provincia_id 2
    region_id 1
    localidad_id 2
    grupo_id 1
    registro_id 3
    nombre "Los Chaquenos"
    condicion_id 1
  end
end