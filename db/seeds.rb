# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
o1 = Owner.create(name: 'teste1', email: 'teste1')
o2 = Owner.create(name: 'teste2', email: 'teste2')
o3 = Owner.create(name: 'teste3', email: 'teste3')
Certificate.create(cn: 'teste1', owner: o1)
Certificate.create(cn: 'teste2', owner: o1)
Certificate.create(cn: 'teste3', owner: o1)
Certificate.create(cn: 'teste4', owner: o2)
