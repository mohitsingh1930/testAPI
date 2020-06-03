const {Client} = require("pg")
const dotenv = require("dotenv")


dotenv.config()


module.exports.Database = class Database {
	constructor(config) {
			this.connection = new Client(config);
			this.connection.connect();
	}
	query(sql) {
		return new Promise((resolve, reject) => {
			this.connection.query(sql, (err, result) => {
				if(err)
					return reject(err);
				resolve(result);
			});
		});
	}
	close() {
		return new Promise((resolve, reject) => {
			this.connection.end(err => {
				if(err)
					return reject(err);
				resolve();
			});
		});
	}
}

// console.log(process.env.DB_HOST, process.env.JWT_SECRET)

module.exports.Defaults = {
	DB_NAME: process.env.DB_NAME,
	DB_USER: process.env.DB_USER,
	DB_PASSWORD: process.env.DB_PASSWORD,
	DB_HOST: process.env.DB_HOST,
	JWT_SECRET: process.env.JWT_SECRET
}