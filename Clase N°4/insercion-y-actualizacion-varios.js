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
    dni: { type: Sequelize.STRING, allowNull: false } 
    }, { sequelize, modelName: 'user' });

sequelize.sync()
.then(() => User.create({
    firstName: 'Pavlov',
    lastName: 'Gerez',
    dni: '42424242'
}))
.then(() => User.create({
    firstName: 'Gerardo',
    lastName: 'Ford',
    dni: '56345364'
}))
.then(() => User.create({
    firstName: 'Ricardo',
    lastName: 'Nixon',
    dni: '12424524'
}))
.then(() => User.create({
    firstName: 'Petruccio',
    lastName: 'Auditore',
    dni: '42424242'
}))
.then(jane => {
    console.log(jane.toJSON());
})
.then(() =>  //Actualiza 
    User.update( {firstName: "Enrique"}, {
        where: { 
            dni: '4%'}
    })
.then(() => { console.log("Done"); }) );
