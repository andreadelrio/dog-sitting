states = {"Distrito Federal" => ["Xochimilco", "Tlalpan", "Tláhuac", "Magdalena Contreras", "Milpa Alta", "Miguel Hidalgo", "Venustiano Carranza", "Iztapalapa", "Iztacalco", "Gustavo A. Madero", "Cuauhtémoc", "Coyoacán", "Cuajimalpa de Morelos", "Benito Juárez", "Azcapotzalco", "Álvaro Obregón"], "Estado de México" => ["Texcoco", "Acolman", "Coacalco", "Toluca", "Tlalnepantla", "Nuacalpan", "Metepec", "Cuautitlan Izcalli", "Cuautitlan ", "Atizapán"], "Guadalajara" => ["Zapopan"], "Nuevo León" => ["Escobedo", "San Pedro", "San Nicolas de los Garza", "Monterrey"]}

states.each do |key, pair|
  State.find_or_create_by(name: key)
  state = State.find_by_name(key)
  pair.each do |location|
    Location.find_or_create_by(name: location, state_id: state.id)
  end
end

locations = [name: "Texcoco", utf_name: "Texcoco"], [name: "Acolman", utf_name: "Acolman"], [name: "Magdalena Contreras", utf_name: "Magdalena Contreras"], [name: "Escobedo", utf_name: "Escobedo"], [name: "San Pedro", utf_name: "San Pedro"], [name: "San Nicolas de los Garza", utf_name: "San Nicolas de los Garza"], [name: "Monterrey", utf_name: "Monterrey"], [name: "Zapopan", utf_name: "Zapopan"], [name: "Toluca", utf_name: "Toluca"], [name: "Tlalnepantla", utf_name: "Tlalnepantla"], [name: "Nuacalpan", utf_name: "Nuacalpan"], [name: "Metepec", utf_name: "Metepec"], [name: "Cuautitlan Izcalli", utf_name: "Cuautitlan Izcalli"], [name: "Cuautitlan", utf_name: "Cuautitlan"], [name: "Atizapán", utf_name: "Atizapán"], [name: "Xochimilco", utf_name: "Xochimilco"], [name: "Tlalpan", utf_name: "Tlalpan"], [name: "Tláhuac", utf_name: "Tláhuac"], [name: "Milpa Alta", utf_name: "Milpa Alta"], [name: "Miguel Hidalgo", utf_name: "Miguel Hidalgo"], [name: "Venustiano Carranza", utf_name: "Venustiano Carranza"], [name: "Iztapalapa", utf_name: "Iztapalapa"], [name: "Iztacalco", utf_name: "Iztacalco"], [name: "Gustavo A. Madero", utf_name: "Gustavo A. Madero"], [name: "Cuauhtémoc", utf_name: "Cuauhtémoc"], [name: "Coyoacán", utf_name: "Coyoacán"], [name: "Cuajimalpa de Morelos", utf_name: "Cuajimalpa de Morelos"], [name: "Benito Juárez", utf_name: "Benito Juárez"], [name: "Azcapotzalco", utf_name: "Azcapotzalco"], [name: "Alvaro Obregon", utf_name: "Alvaro Obregon"]

locations.each do |data|
	location = Location.find_by_name(data[0][:name])
	unless location.nil?
		location.utf_name = data[0][:utf_name]
		location.save
	end
end


ages = ["Cachorros", "Adultos"]

ages.sort!.each do |age|
  Age.find_or_create_by(age_group_name: age)
end

sizes = ["Pequeños", "Medianos", "Grandes"]

sizes.sort!.each do |size|
  Size.find_or_create_by(size_title: size)
end

properties = ["Casa", "Departamento"]

properties.sort!.each do |property|
  Property.find_or_create_by(property_name: property)
end