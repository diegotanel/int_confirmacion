class Principal < ActiveRecord::Base
	has_many :provincias
	has_many :nombres
	has_many :grupos
	has_many :localidades
	has_many :condiciones
end
