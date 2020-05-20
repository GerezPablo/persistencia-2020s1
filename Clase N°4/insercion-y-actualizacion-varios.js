const Sequelize = require('sequelize');

const sequelize = new Sequelize('clase4', 'root', '', { host: 'localhost', dialect: 'mariadb' });

sequelize
  .authenticate()
  .then(() => { console.log('Todo Correcto.'); }) 
  .catch(err => { console.error(`Che paso esto: ${err}. Fijate que onda.`); });


class User extends Sequelize.Model {}
User.init({
    firstName: Sequelize.STRING,
    lastName: Sequelize.STRING, 
    age: Sequelize.INTEGER,
    dni: { type: Sequelize.INTEGER, allowNull: false } 
    }, { sequelize, modelName: 'user' });

sequelize.sync()
.then(() => User.create({
    firstName: 'Pavlov',
    lastName: 'Gerez',
    age: 20,
    dni: '42424242'
}))
.then(() => User.create({
    firstName: 'Gerardo',
    lastName: 'Ford',
    age: 40,
    dni: '56345364'
}))
.then(() => User.create({
    firstName: 'Ricardo',
    lastName: 'Nixon',
    age:  56,
    dni: '12424524'
}))
.then(() => User.create({
    firstName: 'Petruccio',
    lastName: 'Auditore',
    age: 12,
    dni: '42424242'
}))
.then(jane => {
    console.log(jane.toJSON());
})

.then(() =>  //Actualiza 
    User.update( {firstName: "Enrique"}, {
        where: {
            dni: {
              [Sequelize.like]: '4%'
            }
        }
    })
.then(() => { console.log("Done"); }) );