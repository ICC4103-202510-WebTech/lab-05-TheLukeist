# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).}


users_data = [
  { email: "maria.garcia@example.com", first_name: "María", last_name: "García" },
  { email: "juan.pere@example.com", first_name: "Juan", last_name: "Pérez" },
  { email: "ana.martinez@example.com", first_name: "Ana", last_name: "Martínez" },
  { email: "carlos.lope@example.com", first_name: "Carlos", last_name: "López" },
  { email: "laura.sanchez@example.com", first_name: "Laura", last_name: "Sánchez" },
  { email: "pedro.rodriguez@example.com", first_name: "Pedro", last_name: "Rodríguez" },
  { email: "sofia.gonza@example.com", first_name: "Sofía", last_name: "González" },
  { email: "diego.fernandez@example.com", first_name: "Diego", last_name: "Fernández" },
  { email: "isabel.mora@example.com", first_name: "Isabel", last_name: "Morales" },
  { email: "lukita.pro@example.com", first_name: "Lucas", last_name: "Pro" },
  { email: "guillermo@example.com", first_name: "guillermo", last_name: "Faundez" },
  { email: "matif14@example.com", first_name: "Matias", last_name: "Fernandez" },
  { email: "alexi7@example.com", first_name: "Alexis", last_name: "Sanchez" },
  { email: "lamil@example.com", first_name: "Lamil", last_name: "Yamal" },
  { email: "cr7@example.com", first_name: "Cristiano", last_name: "Ronaldo" }
]

users_data.each do |user_data|
  User.create!(user_data)
end

10.times do |i|
  Chat.create!(
    sender_id: (i % 10) + 1,
    receiver_id: ((i + 5) % 10) + 1
  )
end

mensajes = [
  "¡Hola! ¿Cómo estás?",
  "¿Qué planes tienes para el fin de semana?",
  "¿Vamos a tomar un café?",
  "Me encantó la película que vimos ayer",
  "¿Has visto el último episodio de la serie?",
  "Necesito tu ayuda con algo",
  "¿Quedamos para cenar?",
  "¡Feliz cumpleaños!",
  "¿Recibiste el documento que te envié?",
  "Gracias por tu ayuda",
  "¿A qué hora llegas?",
  "¡Nos vemos pronto!",
  "¿Qué opinas sobre el nuevo proyecto?",
  "¿Tienes tiempo para una reunión?",
  "¡Excelente trabajo!",
  "Estamo listo jefe",
  "Readi for the action",
  "Amazing",
  "Awesome, increible, proplayer", 
  "Que paso papito",
  "SIUUUUUUUUUUUUUUU"
]

10.times do |i|
  Message.create!(
    chat_id: (i % 10) + 1,
    user_id: (i % 10) + 1,
    body: mensajes.sample
  )
end
