# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Pet.destroy_all
Shelter.destroy_all

shelter1 = Shelter.create(name: "Pet House",
                           address: "12 Main St.",
                           city: "Denver",
                           state: "Colorado",
                           zip: "80001")

shelter2 = Shelter.create(name: "Love Pets",
                           address: "1111 Dog St.",
                           city: "Los Angeles",
                           state: "California",
                           zip: "90210")

shelter3 = Shelter.create(name: "Dogs Rock",
                           address: "Bark Rd.",
                           city: "Boulder",
                           state: "Colorado",
                           zip: "81111")

lucille = shelter1.pets.create!(image: 'https://justsomething.co/wp-content/uploads/2014/08/pitbull-photos-13.jpg',
                              name: "Lucille",
                              age: 9,
                              sex: "female",
                              status: false,
                              description: "Lovable Pitbull")

george = shelter1.pets.create!(image: 'https://i1.wp.com/puppytoob.com/wp-content/uploads/2017/05/Golden-retriever.jpg?resize=752%2C443',
                              name: "George",
                              age: 4,
                              status: false,
                              sex: "male")

bob = shelter1.pets.create!(image: 'https://i.ytimg.com/vi/8FCSw-ST8hA/maxresdefault.jpg',
                              name: "Bob",
                              description: "Handsome Pug!",

                              age: 2,
                              sex: "male")

gladys = shelter2.pets.create!(image: 'https://static.ddmcdn.com/en-us/apl/breedselector/images/breed-selector/dogs/breeds/dachshund-standard_01_lg.jpg',
                              name: "Gladys",
                              description: "A total terror!",
                              age: 4,
                              sex: "female")

maceo = shelter2.pets.create!(image: 'https://upload.wikimedia.org/wikipedia/commons/0/00/1._DSC_0346_%2810096362833%29.jpg',
                              name: "Maceo Parker",
                              age: 10,
                              description: "Best damn dog around!",
                              sex: "male")

charlie = shelter3.pets.create!(image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ9IcR0ehgkAEqxBilz3GgsoQDLynWZILEPbmHQRPUrrdU0kXKV&usqp=CAU',
                              name: "Charles",
                              age: 6,
                              description: "Your new best friend",
                              sex: "male")
