const bcryptjs = require('bcryptjs');
const nodemailer = require('nodemailer');
const { google } = require("googleapis");
const OAuth2 = google.auth.OAuth2;
const jwt = require('jsonwebtoken');
const JWT_KEY = process.env.JWT_KEY;
const JWT_RESET_KEY = process.env.JWT_RESET_KEY;
const PRIVATE_KEY = process.env.PRIVATE_KEY;


//------------ Account Model ------------//
const Account = require('../Model/Account');
const { Cart } = require('../Model/Cart');
const User = require('../Model/User');

//------------ Register Handle ------------//
exports.registerHandle = (req, res) => {
    const name = (req.body.name);
    const email = (req.body.email).trim().toLowerCase();
    const password = (req.body.password);
    const password2 = (req.body.password2);
    const id_role = 2;


    //------------ Checking required fields ------------//
    if (!name || !email || !password || !password2) {
        res.status(400).json({
            message: 'Please enter all fields',
            status: false
        });
    }

    //------------ Checking password mismatch ------------//
    if (password != password2) {
        res.status(400).json({
            message: 'Passwords do not match',
            status: false
        });
    }

    //------------ Checking password length ------------//
    if (password.length < 8) {
        res.status(400).json({
            message: 'Password must be at least 8 characters',
            status: false
        });
    }
    if (false) {
        res.status(400).json({
            message: 'Error',
            status: false
        });
    } else {
        //------------ Validation passed ------------//
        Account.findOne({ email: email }).then(account => {
            if (account) {
                res.status(400).json({
                    message: 'Email ID already registered',
                    status: false
                });
            } else {
                const oauth2Client = new OAuth2(
                    "173872994719-pvsnau5mbj47h0c6ea6ojrl7gjqq1908.apps.googleusercontent.com", // ClientID
                    "OKXIYR14wBB_zumf30EC__iJ", // Client Secret
                    "https://developers.google.com/oauthplayground" // Redirect URL
                );

                oauth2Client.setCredentials({
                    refresh_token: "1//04T_nqlj9UVrVCgYIARAAGAQSNwF-L9IrGm-NOdEKBOakzMn1cbbCHgg2ivkad3Q_hMyBkSQen0b5ABfR8kPR18aOoqhRrSlPm9w"
                });
                const accessToken = oauth2Client.getAccessToken()

                const token = jwt.sign({ name, email, password }, JWT_KEY, { expiresIn: '30m' });
                const CLIENT_URL = 'http://' + req.headers.host;

                const output = `
                <h2>Please click on below link to activate your account</h2>
                <p>${CLIENT_URL}/api/v1/web/auth/activate/${token}</p>
                <p><b>NOTE: </b> The above activation link expires in 30 minutes.</p>
                `;

                const transporter = nodemailer.createTransport({
                    service: 'gmail',
                    auth: {
                        type: "OAuth2",
                        user: "nodejsa@gmail.com",
                        clientId: "173872994719-pvsnau5mbj47h0c6ea6ojrl7gjqq1908.apps.googleusercontent.com",
                        clientSecret: "OKXIYR14wBB_zumf30EC__iJ",
                        refreshToken: "1//04T_nqlj9UVrVCgYIARAAGAQSNwF-L9IrGm-NOdEKBOakzMn1cbbCHgg2ivkad3Q_hMyBkSQen0b5ABfR8kPR18aOoqhRrSlPm9w",
                        accessToken: accessToken
                    },
                });

                // send mail with defined transport object
                const mailOptions = {
                    from: '"H3M" <nodejsa@gmail.com>', // sender address
                    to: email, // list of receivers
                    subject: "Account Verification: NodeJS Auth ✔", // Subject line
                    generateTextFromHTML: true,
                    html: output, // html body
                };

                transporter.sendMail(mailOptions, (error, info) => {
                    if (error) {

                        res.status(400).json({
                            message: 'Something went wrong on our end. Please register again.',
                            status: false
                        });
                    } else {
                        console.log('Mail sent : %s', info.response);
                        res.status(200).json({
                            message: 'Activation link sent to email ID. Please activate to log in.',
                            status: true
                        });
                    }
                })

            }
        });
    }
}

//------------ Activate Account Handle ------------//
exports.activateHandle = (req, res) => {
    const token = req.params.token;
    let errors = [];
    if (token) {
        jwt.verify(token, JWT_KEY, (err, decodedToken) => {
            if (err) {

                res.send('Incorrect or expired link! Please register again.');
            } else {

                const id_role = 2;
                const { name, email, password } = decodedToken;
                Account.findOne({ email: email }).then(account => {
                    if (account) {

                        res.send('Email ID already registered! Please log in.');
                    } else {
                        const newAccount = new Account({
                            name,
                            email,
                            password,
                            id_role
                        });

                        const fullname = "";
                        const urlImage = "";
                        const id_account = newAccount.id;
                        const phone = "";
                        const gender = true;

                        const newUser = new User({
                            fullname,
                            id_account,
                            phone,
                            gender,
                            urlImage
                        });
                        newUser.save();

                        const product = [];
                        const newCart = new Cart({
                            product,
                            id_account
                        });
                        newCart.save();

                        bcryptjs.genSalt(10, (err, salt) => {
                            bcryptjs.hash(newAccount.password, salt, (err, hash) => {
                                if (err) throw err;
                                newAccount.password = hash;
                                newAccount
                                    .save()
                                    .then(account => {
                                        res.send('Account activated. You can now log in.');
                                    })
                                    .catch(err => console.log(err));
                            });
                        });
                    }
                });
            }

        })
    } else {
        console.log("Account activation error!")
    }
}

//------------ Forgot Password Handle ------------//
exports.forgotPassword = (req, res) => {
    const { email } = req.body;

    let errors = [];

    //------------ Checking required fields ------------//
    if (!email) {
        res.status(400).json({
            message: 'Please enter an email ID!',
            status: false
        });
    }


    if (false) {} else {
        Account.findOne({ email: email }).then(account => {
            if (!account) {
                //------------ User already exists ------------//
                res.status(400).json({
                    message: 'Account with Email ID does not exist!',
                    status: false
                });

            } else {

                const oauth2Client = new OAuth2(
                    "173872994719-pvsnau5mbj47h0c6ea6ojrl7gjqq1908.apps.googleusercontent.com", // ClientID
                    "OKXIYR14wBB_zumf30EC__iJ", // Client Secret
                    "https://developers.google.com/oauthplayground" // Redirect URL
                );

                oauth2Client.setCredentials({
                    refresh_token: "1//04T_nqlj9UVrVCgYIARAAGAQSNwF-L9IrGm-NOdEKBOakzMn1cbbCHgg2ivkad3Q_hMyBkSQen0b5ABfR8kPR18aOoqhRrSlPm9w"
                });
                const accessToken = oauth2Client.getAccessToken()

                const token = jwt.sign({ _id: account._id }, JWT_RESET_KEY, { expiresIn: '30m' });
                const CLIENT_URL = 'http://' + req.headers.host;
                const output = `
                <h2>Your new account password</h2>
                <p>123456789</p>
                `;
                var password = '123456789';
                bcryptjs.genSalt(10, (err, salt) => {
                    bcryptjs.hash(password, salt, (err, hash) => {
                        if (err) throw err;
                        password = hash;

                        Account.findByIdAndUpdate({ _id: account._id }, { password },
                            function(err, result) {
                                if (err) {
                                    res.status(400).json({
                                        message: 'Error resetting password!',
                                        status: false
                                    });
                                }
                            });

                    });
                });


                Account.updateOne({ resetLink: token }, (err, success) => {
                    if (err) {
                        res.status(400).json({
                            message: 'Error resetting password!',
                            status: false
                        });
                    } else {
                        const transporter = nodemailer.createTransport({
                            service: 'gmail',
                            auth: {
                                type: "OAuth2",
                                user: "nodejsa@gmail.com",
                                clientId: "173872994719-pvsnau5mbj47h0c6ea6ojrl7gjqq1908.apps.googleusercontent.com",
                                clientSecret: "OKXIYR14wBB_zumf30EC__iJ",
                                refreshToken: "1//04T_nqlj9UVrVCgYIARAAGAQSNwF-L9IrGm-NOdEKBOakzMn1cbbCHgg2ivkad3Q_hMyBkSQen0b5ABfR8kPR18aOoqhRrSlPm9w",
                                accessToken: accessToken
                            },
                        });

                        // send mail with defined transport object
                        const mailOptions = {
                            from: '"H3M" <nodejsa@gmail.com>', // sender address
                            to: email, // list of receivers
                            subject: "Account Password Reset: NodeJS Auth ✔", // Subject line
                            html: output, // html body
                        };

                        transporter.sendMail(mailOptions, (error, info) => {
                            if (error) {
                                console.log(error);
                                res.status(400).json({
                                    message: 'Something went wrong on our end. Please try again later.',
                                    status: false
                                });
                                // res.redirect('/auth/forgot');
                            } else {
                                console.log('Mail sent : %s', info.response);
                                res.status(200).json({
                                    message: 'Password reset link sent to email ID. Please follow the instructions.',
                                    status: true
                                });
                            }
                        })
                    }
                })

            }
        });
    }
}

exports.resetPassword = (req, res) => {
    var { password, password2 } = req.body;
    const id = req.params.id;
    let errors = [];

    //------------ Checking required fields ------------//
    if (!password || !password2) {
        res.status(400).json({
            message: 'Please enter all fields.',
            status: false
        });
    }

    //------------ Checking password length ------------//
    else if (password.length < 8) {
        res.status(400).json({
            message: 'Password must be at least 8 characters.',
            status: false
        });
    }

    //------------ Checking password mismatch ------------//
    else if (password != password2) {
        res.status(400).json({
            message: 'Passwords do not match.',
            status: false
        });
    } else {
        bcryptjs.genSalt(10, (err, salt) => {
            bcryptjs.hash(password, salt, (err, hash) => {
                if (err) throw err;
                password = hash;

                Account.findByIdAndUpdate({ _id: id }, { password },
                    function(err, result) {
                        if (err) {
                            res.status(400).json({
                                message: 'Error resetting password!',
                                status: false
                            });
                        } else {
                            res.status(200).json({
                                message: 'Password reset successfully!',
                                status: true
                            });
                        }
                    }
                );

            });
        });
    }
}

//------------ Login Handle ------------//
exports.login = (req, res) => {
    try {
        const email = (req.body.email).trim().toLowerCase();
        if (req.body && email && req.body.password) {
            Account.find({ email: email }, (err, data) => {
                if (data.length > 0) {


                    if (bcryptjs.compareSync(req.body.password, data[0].password)) {
                        checkUserAndGenerateToken(data[0], req, res);
                        // const account = Account.findOne({ email }).select("+password");
                        // const account = Account.findOne({ email });
                        // sendToken(account, 200, res);
                    } else {

                        res.status(400).json({
                            message: 'Email or password is incorrect!',
                            status: false
                        });
                    }

                } else {
                    res.status(400).json({
                        message: 'Email or password is incorrect!',
                        token: "",
                        status: false
                    });
                }
            })
        } else {
            res.status(400).json({
                message: 'Add proper parameter first!',
                token: "",
                status: false
            });
        }
    } catch (e) {
        res.status(400).json({
            message: 'Something went wrong!',
            token: "",
            status: false
        });
        logger.info(e);
        logger.error(e);
    }
}

function checkUserAndGenerateToken(data, req, res) {
    jwt.sign({ Account: data.username, id: data._id }, PRIVATE_KEY, { expiresIn: '1d' }, (err, token) => {
        if (err) {
            res.status(400).json({
                status: false,
                message: err,
            });
        } else {
            res.json({
                message: 'Login Successfully.',
                token: token,
                status: true
            });

        }
    });
}

//------------ Logout Handle ------------//
exports.logoutHandle = (req, res) => {
    req.session.destroy((err) => {
        res.json({
            message: 'Logout Successfully.',
            status: true
        });
    })
}