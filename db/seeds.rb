# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
portals = Portal.create([{ name: 'Chrome', current: 65 },
                         { name: 'Safari', current: 11 },
                         { name: 'Firefox', current: 59 },
                         { name: 'Opera', current: 52 },
                         { name: 'Microsoft Edge', current: 15 },
                         { name: 'Internet Explorer', current: 11 }])
