var express = require('express');
var router = express.Router();
const {Client} = require("pg")
const bcrypt = require("bcrypt")
const jwt = require("jsonwebtoken")
const crypto = require("crypto-random-string")

const util = require("../util");

var defaults = util.Defaults

const db = new util.Database({
  user: defaults.DB_USER || 'home',
  host: defaults.DB_HOST || 'localhost',
  database: defaults.DB_NAME || 'mydb',
  password: defaults.DB_PASSWORD || 'home@123',
  port: 5432,
})


// middleware for jwt verification
const decode = function (req, res, next) {

	let secretKey = defaults.JWT_SECRET || "secret";

	// hoping you would sent jwt token string in a authorization header
	let token = req.headers.authorization;

	// verify JWT
	jwt.verify(token, secretKey, (err, result) => {
		if(err) {

			console.log(err)

			res.status(401).json({
				msg: "Unauthorized to access API"
			})

		}
		else {

			// check login token, which governs user is logged in or not
			db.query(`select id, user_id from logins where user_id=${result.userId} and validate_string='${result.loginToken}' and logout='f'`)
			.then((resolve) => {

				if(resolve.rows.length != 0) {

					req.payload = result;
					next()

				}
				else {

					res.status(406).json({
						msg: "Invalid logged in credentials, login first"
					})

					throw `Validation token not matched`

				}

			})
			.catch((err) => {

				console.log(err)

				if(typeof err != "string") {

					res.status(500).json({
						msg: "Internal Server Error"
					})

				}

			})

		}

	})

}


/* GET users listing. */
router.get('/user', decode, function(req, res, next) {
  res.send(`Hello, ${req.payload.email}`);
});


// creating new user with email and password
router.post('/user/create', function(req, res, next) {

	//check if email and password are provided or not
	if(!req.body.email)
		return res.status(406).json({msg: "email not given"})

	if(!req.body.password)
		return res.status(406).json({msg: "password not given"})

	console.log(req.body.email, req.body.password, req.body.name)


	// User is already present(prevent multiple accounts with same email)
	db.query(`select * from users where email='${req.body.email}'`)
	.then((resolve) => {

		if(resolve.rows.length > 0) {

			res.status(409).json({
				msg: `User (email: ${req.body.email}) already exists`
			})
			throw `User (email: ${req.body.email}) already exists`

		}
		else {

			let passwordHash = bcrypt.hashSync(req.body.password, 10);

			return db.query(`insert into users (name, email, password) values('${req.body.name?req.body.name:""}', '${req.body.email}', '${passwordHash}')`)

		}

	})
	// Created responnse, user has been created
	.then((resolve) => {

		console.log(resolve);

		res.status(201).json({
			msg: `User (email: ${req.body.email}) Created`
		})

	})
	// server error if some error occurs(like a database error)
	.catch((err) => {

		console.log(err);

		if(typeof err != "string") {

			res.status(500).json({
				msg: "Internal Server Error"
			})

		}

	})


});


// user login
router.post('/user/login', (req, res) => {

	let {email, password} = req.body;

	//check if email and password are provided or not
	if(!req.body.email)
		return res.status(406).json({msg: "email not given"})

	if(!req.body.password)
		return res.status(406).json({msg: "password not given"})

	db.query(`select id, email, password from users where email='${req.body.email}'`)
	.then((result) => {

		let matched = bcrypt.compareSync(req.body.password, result.rows[0].password);

		if(!matched) {

			res.status(401).json({
				msg: "authentication failed"
			})

			reject("password is incorrect")

		}
		else {

			let validationToken = crypto({length: 10})

			// check user logged in or not
			db.query(`select id from logins where user_id=${result.rows[0].id} and logout='f'`)
			// if already logged in
			.then(function (result2) {

				if(result2.rows.length > 0) {

					res.status(409).json({
						msg: `Already loggedIn`
					})

					throw "Already present"

				}
				else {

					// insert validation token for further jwt login token validation
					return db.query(`insert into logins (user_id, validate_string) values(${result.rows[0].id}, '${validationToken}')`)

				}

			})
			.then((resolve) => {

				let token = jwt.sign(
					{
						email: result.rows[0].email,
						userId: result.rows[0].id,
						loginToken: validationToken
					},
					defaults.JWT_SECRET
				)

				res.status(200).json({
					msg: "logged in",
					token
				})

			})
			.catch((err) => {

				if(typeof err != "string") {
		
					console.log(err)
		
					res.status(500).json({
						msg: "Internal Server Error"
					})
		
				}
		
			})

		}

	})
	.catch((err) => {

		if(typeof err != "string") {

			console.log(err)

			res.status(500).json({
				msg: "Internal Server Error"
			})

		}

	})

})


// new like or superlike entry in app for an image
router.post('/image/like|superlike', decode, (req, res) => {

	let {userId, imageId} = req.payload;

	console.log(req.originalUrl)
	let likeType = req.originalUrl.split("/")[2];

	// check if user exists or not for the given userid
	db.query(`select id from users where id=${userId}`)
	.then(function (result) {

		if(result.rows.length == 0) {

			res.status(406).json({
				msg: "User doesn't exists"
			})

			throw 'User not exists';

		}
		else {

			// check if already liked
			return db.query(`select id from likes where user_id=${userId} and image_id=${imageId} and type='${likeType}'`)

		}

	})
	// skips if already liked or superliked
	.then(function (result) {

		if(result.rows.length > 0) {

			res.status(409).json({
				msg: `Already ${likeType}d`
			})

			throw "Already present"

		}
		else {

			// liketype is for normal like or superlike,
			// based on this we will conclude whose image should be visible to the user who is being liked
			return db.query(`insert into likes (image_id, user_id, type) values(${imageId}, ${userId}, '${likeType}')`)

		}

	})
	// Ok response, like has been recorded
	.then(function (result) {

		res.status(200).json({
			msg: "Image " + likeType
		})

	})
	// server error if some error occurs(like a database error)
	.catch((err) => {

		console.log(err)
		if(typeof err != "string") {

			res.status(500).json({
				msg: "Internal Server Error"
			})

		}

	})

})


router.post('/user/block', decode, (req, res) => {

	let {blocker, blocked} = req.payload;

	// check if both user ids are present
	db.query(`select id from users where id=${blocker}`)
	.then(function (result) {

		if(result.rows.length == 0) {

			res.status(406).json({
				msg: `User ${blocker} doesn't exists`
			})

			reject('User not exists')

		}
		else {

			return db.query(`select id from users where id=${blocked}`)

		}

	})
	.then(function (result) {

		if(result.rows.length == 0) {

			res.status(406).json({
				msg: `User ${blocked} doesn't exists`
			})

			reject('User not exists')

		}
		else {

			return db.query(`select id from blocks where (blocker_id=${blocker} and blocked_id=${blocked}) or (blocker_id=${blocked} and blocked_id=${blocker})`)

		}

	})
	// skips if already blocked
	.then(function (result) {

		if(result.rows.length > 0) {

			res.status(409).json({
				msg: `Already blocked`
			})

			throw `blocker ${blocker} already blocked ${blocked} or vice versa`

		}
		else {

			return db.query(`insert into blocks (blocker_id, blocked_id) values(${blocker}, ${blocked})`)

		}

	})
	// Ok response, user has been blocked from blocker account
	.then(function (result) {

		res.status(200).json({
			msg: `User ${blocker} blocked ${blocked}`
		})

	})
	// server error if some error occurs(like a database error)
	.catch((err) => {

		console.log(err)
		if(typeof err != "string") {

			res.status(500).json({
				msg: "Internal Server Error"
			})

		}

	})

})




module.exports = router;
