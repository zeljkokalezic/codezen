# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#TODO: read in more secure way
Language.find_or_create_by(:descriptor => 'C',
                           :service_url => 'http://ec2-34-241-92-136.eu-west-1.compute.amazonaws.com:3000/v1/cexecutor',
                           :auth_token => 'a47a8e54b11c4de5a4a351734c80a14a')