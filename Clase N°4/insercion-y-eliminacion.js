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
    dni: { type: Sequelize.INTEGER, allowNull: false } 
    }, { sequelize, modelName: 'user' });

sequelize.sync()
.then(() => User.create({
    firstName: 'Ernesto',
    lastName: 'Palerga',
    dni: 0
}))
.then(jane => {
    console.log(jane.toJSON());
}).then(() =>  //Borra
User.destroy({
    where: { dni: 0 }
}).then(() => { console.log("Elimine Registro"); })
);



