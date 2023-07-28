const { Client, Events, GatewayIntentBits, Partials } = require('discord.js');
const client = new Client({ intents: ['8', 		GatewayIntentBits.Guilds,
GatewayIntentBits.GuildMessages,
GatewayIntentBits.MessageContent,
GatewayIntentBits.GuildMembers,
GatewayIntentBits.GuildMessageReactions,
GatewayIntentBits.GuildEmojisAndStickers,],
partials: [Partials.Message, Partials.Channel, Partials.Reaction] });

const mysql = require('mysql2')
const config = require('./config/config.json');

var con = mysql.createConnection({
    host: config.host,
    user: config.user,
    password: config.password,
    database: config.database
});

const utf8 = require('utf8');

con.connect(err => {
if (err) throw err;
console.log('connected');
});

client.once('ready', () => {
console.log('Ready!');
function checkUserRoles() {
    con.query("SELECT * FROM `users_lol`", (err, lolUsersRows) => {
        if (err) throw err;
        const CPGUILD = client.guilds.cache.get("621398425912606742");
        let roleActiveSub = CPGUILD.roles.cache.get("621399169499922442");
        let roleFormerCustomer = CPGUILD.roles.cache.get("645935663618850816");
        const currentDate = new Date().toISOString().slice(0, 19).replace('T', ' ');
        const members = CPGUILD.members;
        CPGUILD.members.fetch().then(guild => {
            guild.map(m => {
                if (!m.user.bot) {
                    let hasIDinDB = false;
                    let endDate = "";
                    let member = "";
                    for (let i = 0; i < lolUsersRows.length; i++) {
                        if (m.id == lolUsersRows[i].discordToken) {
                            // console.log(member.displayName)
                            // console.log(lolUsersRows[i].discordToken)
                            hasIDinDB = true
                            endDate = lolUsersRows[i].endSub.toISOString().slice(0, 19).replace('T', ' ');
                            member = members.cache.get(lolUsersRows[i].discordToken);
                        }
                    }
                    if (hasIDinDB) {
                        if (member) {
                            if (endDate >= currentDate) {
                                if (member.roles.cache.some(r => r.id == roleFormerCustomer.id)) {
                                    member.roles.remove(roleFormerCustomer.id);
                                }
                                member.roles.add(roleActiveSub.id);
                            }
                            else {
                                if (member.roles.cache.some(r => r.id == roleActiveSub.id)) {
                                    member.roles.remove(roleActiveSub.id);
                                }
                                member.roles.add(roleFormerCustomer.id);
                            }
                        }
                    } else {
                        member = members.cache.get(m.id)
                        // console.log(member.displayName)
                        member.roles.remove(roleActiveSub.id);
                        member.roles.remove(roleFormerCustomer.id);
                    }
                }
            });
        });
    });
}
checkUserRoles();
setInterval(checkUserRoles, 600000);
});

client.on(Events.MessageReactionAdd, async (reaction, userReaction) => { // When a reaction is added]
if (reaction.partial) {
    try {
        await reaction.fetch();
    } catch (error) {
        console.error('Something went wrong when fetching the message: ', error);
        return;
    }
}
if(userReaction.bot) return; // If the user who reacted is a bot, return
const CPGUILD = client.guilds.cache.get("621398425912606742");
let roleActiveSub = CPGUILD.roles.cache.get("621399169499922442");
let roleFormerCustomer = CPGUILD.roles.cache.get("645935663618850816");
const verificationPaypalChannel = client.channels.cache.get('852489946417463327');
const requestedFeatureList = client.channels.cache.get('852869291505352734');
if (reaction.message.channel.id == "852489946417463327") {
    if (reaction.emoji.name == "yes") {
        var email = reaction.message.content.split("Email:")[1];
        email = email.split("Pricing:")[0];
        email = email.replace(" ", "");
        email = email.replace("\n", "");
        var sql = "SELECT * FROM `payments_paypal` WHERE email = ? AND status = ?";
        var insert = [email, 'Pending'];
        sql = mysql.format(sql, insert);
        con.query(sql, (err, rows) => {
            if (err) throw err;
            if (rows && rows.length) {
                // retrieve current end sub date, add paid sub on top of it, update end sub time
                var discordToken = rows[0]["discordToken"];
                var sql1 = "SELECT * from users_lol WHERE discordToken = ?";
                var insert1 = [discordToken];
                sql1 = mysql.format(sql1, insert1);
                con.query(sql1, (err, userLolRows) => {
                    if (err) throw err;
                    var today = new Date();
                    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
                    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var dateTime = date+' '+time;
                    var currentEndSubDate = userLolRows[0]["endSub"];
                    var subType = rows[0]["subtype"];
                    var days = 0;
                    if (subType == 18) {
                        days = 8;
                    }
                    if (subType == 33) {
                        days = 15;
                    }
                    if (subType == 48) {
                        days = 22;
                    }
                    if (subType == 63) {
                        days = 31;
                    }
                    currentEndSubDate = new Date(currentEndSubDate).toISOString().slice(0, 19).replace('T', ' ');
                    dateTime = new Date(dateTime).toISOString().slice(0, 19).replace('T', ' ');
                    if (currentEndSubDate > dateTime) {
                        var result = new Date(currentEndSubDate);
                        result.setDate(result.getDate() + days);
                        result = new Date(result).toISOString().slice(0, 19).replace('T', ' ');
                        con.query("UPDATE payments_paypal SET status = ? WHERE discordToken = ? ORDER BY id DESC LIMIT 1", ['Completed', discordToken], (err, rows) => {
                            if (err) throw err;
                        });
                        con.query("UPDATE users_lol SET endSub = ? WHERE discordToken = ?", [result, discordToken], (err, rows) => {
                            if (err) throw err;
                        });
                        const user = client.users.cache.get(discordToken);
                        const members = CPGUILD.members;
                        CPGUILD.members.fetch().then(guild => {
                            guild.map(m => {
                                var member = members.cache.get(discordToken);
                                member.roles.add(roleActiveSub.id);
                                member.roles.remove(roleFormerCustomer.id);
                            })
                        });
                        user.send("Subscription Added " + result +", Please restart loader for it to take effect");
                    } else {
                        var result = new Date(dateTime);
                        result.setDate(result.getDate() + days);
                        result = new Date(result).toISOString().slice(0, 19).replace('T', ' ');
                        con.query("UPDATE payments_paypal SET status = ? WHERE discordToken = ? ORDER BY id DESC LIMIT 1", ['Completed', discordToken], (err, rows) => {
                            if (err) throw err;
                        });
                        con.query("UPDATE users_lol SET endSub = ? WHERE discordToken = ?", [result, discordToken], (err, rows) => {
                            if (err) throw err;
                        });
                        const user = client.users.cache.get(discordToken);
                        const members = CPGUILD.members;
                        CPGUILD.members.fetch().then(guild => {
                            guild.map(m => {
                                var member = members.cache.get(discordToken);
                                member.roles.add(roleActiveSub.id);
                                member.roles.remove(roleFormerCustomer.id);
                            })
                        });
                        user.send("Subscription Added " + result +", Please restart loader for it to take effect");
                    }
                });
                var today = new Date();
                var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
                var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var dateTime = date+' '+time;
                verificationPaypalChannel.send("Order Completed: \n" + "Discord Name: " + rows[0]["name"] + "\n" + "Email: " + rows[0]["email"] + "\n" + "Pricing: €" + rows[0]["subtype"]  + "\n" + "Date: " + dateTime + "\n" + "Status: Completed");
            } else {
                // verificationPaypalChannel.send(messageAuthor + " There is no order with that email: " + firstParam[1]);
            }
        });
    }
    if (reaction.emoji.name == "no") {
        var email = reaction.message.content.split("Email:")[1];
        email = email.split("Pricing:")[0];
        email = email.replace(" ", "");
        email = email.replace("\n", "");
        var sql = "SELECT * FROM `payments_paypal` WHERE email = ? AND status = 'Pending'";
        var insert = [email];
        sql = mysql.format(sql, insert);
        con.query(sql, (err, rows) => {
            if (err) throw err;
            if (rows && rows.length) {
                var discordToken = rows[0]["discordToken"];
                con.query("UPDATE payments_paypal SET status = ? WHERE discordToken = ? AND status = ? ORDER BY id DESC LIMIT 1", ['Failed', discordToken, 'Pending'], (err, userLolRows) => {
                    if (err) throw err;
                });
                var today = new Date();
                var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
                var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var dateTime = date+' '+time;
                verificationPaypalChannel.send("Order Not Received: \n" + "Discord Name: " + rows[0]["name"] + "\n" + "Email: " + rows[0]["email"] + "\n" + "Pricing: €" + rows[0]["subtype"]  + "\n" + "Date: " + dateTime + "\n" + "Status: Failed");
                const user = client.users.cache.get(discordToken);
                user.send("Transaction failed, if you did sent the money contact Scortch. If not do the process again.");
            } else {
                // verificationPaypalChannel.send(messageAuthor + " There is no order with that email: " + firstParam[1]);
            }
        });
    }
    if (reaction.emoji.name == "jew") {
        var email = reaction.message.content.split("Email:")[1];
        email = email.split("Pricing:")[0];
        email = email.replace(" ", "");
        email = email.replace("\n", "");
        var sql = "SELECT * FROM `payments_paypal` WHERE email = ? AND status = ?";
        var insert = [email, 'Pending'];
        sql = mysql.format(sql, insert);
        con.query(sql, (err, rows) => {
            if (err) throw err;
            if (rows && rows.length) {
                // retrieve current end sub date, add paid sub on top of it, update end sub time
                var discordToken = rows[0]["discordToken"];
                var user = client.users.cache.get(discordToken);
                con.query("UPDATE payments_paypal SET status = ? WHERE discordToken = ? AND status = ? ORDER BY id DESC LIMIT 1", ['Underpaid', discordToken, 'Pending'], (err, userLolRows) => {
                    if (err) throw err;
                });
                var today = new Date();
                var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
                var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                var dateTime = date+' '+time;
                verificationPaypalChannel.send("Order Underpaid: \n" + "Discord Name: " + rows[0]["name"] + "\n" + "Email: " + rows[0]["email"] + "\n" + "Pricing: €" + rows[0]["subtype"]  + "\n" + "Date: " + dateTime + "\n" + "Status: Underpaid");
                user.send("You have not sent enough money, contact Scortch to fix your payment");
            } else {
                // verificationPaypalChannel.send(messageAuthor + " There is no order with that email: " + firstParam[1]);
            }
        });
    }
}
});

client.on(Events.ThreadCreate, async (channel) => {
    setTimeout(function() { 
        if (channel.parentId == "1086325346711896215") {
            channel.send("We have received your support ticket and will respond within 72hours");
        }
        if (channel.parentId == "1087008742001881200") {
            channel.send("We have received your request ticket and will respond within 72hours");
        }
    }, 1000);
});

client.on('messageCreate', message => {
if (message.content.startsWith("!")) {
    const firstParam = message.content.split(" ");
    const otherArgs = message.content.split("|");
    const awaitingConfirmationPaypalChannel = client.channels.cache.get('852492373719777290');
    const verificationPaypalChannel = client.channels.cache.get('852489946417463327');
    const ferryKe = client.users.cache.get('507482078472962049');
    const requestFeature = client.channels.cache.get('852869080523210762');
    var allTextAfterCommand = "";
    for (var i = 0; i < firstParam.length; i++) {
        if (i == 0) {
            allTextAfterCommand = allTextAfterCommand + firstParam[i];
        } else {
            allTextAfterCommand = allTextAfterCommand + " " + firstParam[i];
        }
    }
    allTextAfterCommand = allTextAfterCommand.split("!add")[1];
    try {
        switch(message.content) {
            case "!setup " + firstParam[1]:
                if (message.channel.id == "621401219184984095") { 
                    const currentUserToken = message.author.id;
                    const CPGUILD = client.guilds.cache.get("621398425912606742");
                    const members = CPGUILD.members;
                    let roleActiveSub = CPGUILD.roles.cache.get("621399169499922442");
                    let roleFormerCustomer = CPGUILD.roles.cache.get("645935663618850816");
                    let roleSetup = CPGUILD.roles.cache.get("948927048938819644");
                    const code = firstParam[1];
                    var sql = "SELECT * FROM `users_lol` WHERE discordToken = ?";
                    var insert = [currentUserToken];
                    sql = mysql.format(sql, insert);
                    con.query(sql, (err, rows) => {
                        if (err) throw err;
                        if (rows.length == 0) {
                            var sql = "SELECT * FROM `init_codes` WHERE code = ?";
                            var insert = [code];
                            sql = mysql.format(sql, insert);
                            con.query(sql, (err, rows) => {
                                if (err) throw err;
                                if (rows && rows.length) {
                                    var today = new Date();
                                    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
                                    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                                    var dateTime = date+' '+time;
                                    var subType = rows[0]["subDuration"];
                                    var endSubDate = "";
                                    if (subType == "1month") {
                                        var today = new Date();
                                        today.setDate(today.getDate() + 31);
                                        endSubDate = new Date(today).toISOString().slice(0, 19).replace('T', ' ');
                                    }
                                    if (subType == "2week") {
                                        var today = new Date();
                                        today.setDate(today.getDate() + 14);
                                        endSubDate = new Date(today).toISOString().slice(0, 19).replace('T', ' ');
                                    }
                                    if (subType == "1week") {
                                        var today = new Date();
                                        today.setDate(today.getDate() + 7);
                                        endSubDate = new Date(today).toISOString().slice(0, 19).replace('T', ' ');
                                    }
                                    if (subType == "trial") {
                                        var today = new Date();
                                        today.setDate(today.getDate() + 1);
                                        endSubDate = new Date(today).toISOString().slice(0, 19).replace('T', ' ');
                                    }
                                    var sql = "INSERT INTO users_lol SET ?";
                                    var sqlInsertArgs = "";
                                    if (code.includes("_Z")) {
                                        sqlInsertArgs = {name: '', password: '', hwid: '', regIP: '', lastIP: '', discordToken: currentUserToken, code: code, startSub: dateTime, endSub: endSubDate, zoomHackOnly: true};
                                    } else {
                                        sqlInsertArgs = {name: '', password: '', hwid: '', regIP: '', lastIP: '', discordToken: currentUserToken, code: code, startSub: dateTime, endSub: endSubDate, zoomHackOnly: false};
                                    }
                                    sql = mysql.format(sql, sqlInsertArgs);
                                    con.query(sql, (err, rows) => {
                                        if (err) throw err;
                                        var sqlDelete = "DELETE FROM init_codes WHERE code = ?";
                                        var sqlDeleteArgs = [code];
                                        sqlDelete = mysql.format(sqlDelete, sqlDeleteArgs);
                                        con.query(sqlDelete, (err, rows) => {
                                            if (err) throw err;
                                            var sql = "INSERT INTO log_success SET ?";
                                            var sqlInsertArgs = {message: 'Succesfully created user', date: dateTime, code: code, hwid: '', discordToken: currentUserToken, adress: ''};
                                            sql = mysql.format(sql, sqlInsertArgs);
                                            con.query(sql, (err, rows) => {
                                                if (err) throw err;
                                                message.delete();
                                                var member = members.cache.get(currentUserToken);
                                                member.roles.add(roleActiveSub.id);
                                            });
                                        });
                                    });
                                } else {
                                    // invalid key input
                                    message.delete();
                                    var member = members.cache.get(currentUserToken);
                                    member.kick();
                                }
                            });
                        } else {
                            // user already exists
                            var member = members.cache.get(currentUserToken);
                            member.roles.add(roleActiveSub.id);
                            member.roles.remove(roleSetup.id);
                        }
                    });
                }
            break;

            case "!showrotation":
                con.query("SELECT * FROM `scripts` ORDER BY `script` ASC", (err, rows) => {
                    if (err) throw err;
                    var rotation = rows.map(m => m.script);
                    message.channel.send("All supported scripts: \n" + rotation);
                });
            break;

            case "!add " + firstParam[1]:
                if (message.channel.id == "1089550311024250920") { 
                    const currentUserToken = message.author.id;
                    const CPGUILD = client.guilds.cache.get("621398425912606742");
                    const members = CPGUILD.members;
                    let roleActiveSub = CPGUILD.roles.cache.get("621399169499922442");
                    let roleFormerCustomer = CPGUILD.roles.cache.get("645935663618850816");
                    let roleSetup = CPGUILD.roles.cache.get("948927048938819644");
                    const code = firstParam[1];
                    var sql = "SELECT * FROM `users_lol` WHERE discordToken = ?";
                    var insert = [currentUserToken];
                    sql = mysql.format(sql, insert);
                    con.query(sql, (err, rows) => {
                        if (err) throw err;
                        if (rows.length) {
                            var currentEndSubDate = rows[0]["endSub"];
                            // var endSubDate = currentEndSubDate.getFullYear()+'-'+(currentEndSubDate.getMonth()+1)+'-'+currentEndSubDate.getDate();
                            // var endSubTime = currentEndSubDate.getHours() + ":" + currentEndSubDate.getMinutes() + ":" + currentEndSubDate.getSeconds();
                            // currentEndSubDate = endSubDate+' '+endSubTime;
                            var sql = "SELECT * FROM `init_codes` WHERE code = ?";
                            var insert = [code];
                            sql = mysql.format(sql, insert);
                            con.query(sql, (err, rows) => {
                                if (err) throw err;
                                if (rows && rows.length) {
                                    var today = new Date();
                                    var subType = rows[0]["subDuration"];
                                    if (subType != "trial") {
                                        var endSubDate = "";
                                        if (currentEndSubDate.getTime() < today.getTime()) {
                                            if (subType == "1month") {
                                                var today = new Date();
                                                today.setDate(today.getDate() + 31);
                                                endSubDate = new Date(today).toISOString().slice(0, 19).replace('T', ' ');
                                            }
                                            if (subType == "2week") {
                                                var today = new Date();
                                                today.setDate(today.getDate() + 14);
                                                endSubDate = new Date(today).toISOString().slice(0, 19).replace('T', ' ');
                                            }
                                            if (subType == "1week") {
                                                var today = new Date();
                                                today.setDate(today.getDate() + 7);
                                                endSubDate = new Date(today).toISOString().slice(0, 19).replace('T', ' ');
                                            }
                                        } else {
                                            if (subType == "1month") {
                                                var newDate = new Date(currentEndSubDate);
                                                newDate.setDate(newDate.getDate() + 31);
                                                endSubDate = new Date(newDate).toISOString().slice(0, 19).replace('T', ' ');
                                            }
                                            if (subType == "2week") {
                                                var newDate = new Date(currentEndSubDate);
                                                newDate.setDate(newDate.getDate() + 14);
                                                endSubDate = new Date(newDate).toISOString().slice(0, 19).replace('T', ' ');
                                            }
                                            if (subType == "1week") {
                                                var newDate = new Date(currentEndSubDate);
                                                newDate.setDate(newDate.getDate() + 7);
                                                endSubDate = new Date(newDate).toISOString().slice(0, 19).replace('T', ' ');
                                            }
                                        }
                                        con.query("UPDATE users_lol SET endSub = ? WHERE discordToken = ?", [endSubDate, currentUserToken], (err, rows) => {
                                            if (err) throw err;
                                            var sqlDelete = "DELETE FROM init_codes WHERE code = ?";
                                            var sqlDeleteArgs = [code];
                                            sqlDelete = mysql.format(sqlDelete, sqlDeleteArgs);
                                            con.query(sqlDelete, (err, rows) => {
                                                if (err) throw err;
                                                var today = new Date();
                                                var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
                                                var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                                                var dateTime = date+' '+time;
                                                var sql = "INSERT INTO log_success SET ?";
                                                var sqlInsertArgs = {message: 'Succesfully added subscription', date: dateTime, code: code, hwid: '', discordToken: currentUserToken, adress: ''};
                                                sql = mysql.format(sql, sqlInsertArgs);
                                                con.query(sql, (err, rows) => {
                                                    if (err) throw err;
                                                    message.delete();
                                                    var member = members.cache.get(currentUserToken);
                                                    member.roles.add(roleActiveSub.id);
                                                });
                                            });
                                        });
                                    } else {
                                        // existing user cannot get trial
                                        message.delete();
                                        var member = members.cache.get(currentUserToken);
                                        member.kick();
                                    }
                                } else {
                                    // invalid key input
                                    message.delete();
                                    var member = members.cache.get(currentUserToken);
                                    member.kick();
                                }
                            });
                        }
                    });
                }
            break;

            case "!reset":
                if (message.channel.id == "1088832686602342481") {
                    currentUserToken = message.author.id;
                    var sql = "SELECT * FROM `users_lol` WHERE discordToken = ?";
                    var insert = [currentUserToken];
                    var today = new Date();
                    var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
                    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
                    var dateTime = date+' '+time;
                    dateTime = new Date(dateTime).toISOString().slice(0, 19).replace('T', ' ');
                    sql = mysql.format(sql, insert);
                    con.query(sql, (err, rows) => {
                        if (err) throw err;
                        if (rows && rows.length) {
                            var sqlSelect = "SELECT * FROM log_reset WHERE hwid = ? AND status = ? AND date >= NOW() - INTERVAL 1 DAY";
                            var sqlInsertSelect = [rows[0]["hwid"], 'Reset'];
                            sqlSelect = mysql.format(sqlSelect, sqlInsertSelect);
                            con.query(sqlSelect, (err, logDeclinedRow) => {
                                if (err) throw err;
                                if (logDeclinedRow && logDeclinedRow.length) {
                                    message.channel.send("You have already used your daily reset <@" + message.author.id + ">");
                                } else {
                                    var sqlDelete = "DELETE FROM log_declined WHERE hwid = ? and status = ?";
                                    var sqlDeleteArgs = [rows[0]["hwid"], 'Declined'];
                                    sqlDelete = mysql.format(sqlDelete, sqlDeleteArgs);
                                    con.query(sqlDelete, (err, rows) => {
                                        if (err) throw err;
                                    });
                                    message.channel.send("Succesfully reset HWID " + "<@" + message.author.id + ">");
                                    var sqlInsertArgs = { status: 'Reset', message:'Reset HWID', date: dateTime, hwid: rows[0]["hwid"], adress: '0' };
                                    con.query("INSERT INTO log_reset SET ?", sqlInsertArgs, (err, rows) => {
                                        if (err) throw err;
                                    });
                                }
                            });
                            message.delete();
                        } else {
                            message.delete();
                            message.channel.send("Something went wrong contact Scortch");
                        }
                    });
                }
            break;

            // case "!pay " + firstParam[1] + " |" + otherArgs[1]:
            //     if (message.channel.id == "852482184211464233") { 
            //         var today = new Date();
            //         var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
            //         var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
            //         var dateTime = date+' '+time;
            //         var messageAuthor = message.author;
            //         var email = firstParam[1];
            //         var subPrice = 0;
            //         var discordToken = message.author.id;
            //         if (otherArgs[1] == " 1 week") {
            //             subPrice = 18;
            //         }
            //         if (otherArgs[1] == " 2 weeks") {
            //             subPrice = 33;
            //         }
            //         if (otherArgs[1] == " 3 weeks") {
            //             subPrice = 48;
            //         }
            //         if (otherArgs[1] == " 1 month") {
            //             subPrice = 63;
            //         }
            //         if (subPrice == 0) {
            //             message.delete();
            //             message.author.send("You did not specify subtype properly");
            //         } else {
            //             var sql = "SELECT * FROM `payments_paypal` WHERE email = ? AND status = ?";
            //             var insert = [email, 'Pending'];
            //             sql = mysql.format(sql, insert);
            //             con.query(sql, (err, rows) => {
            //                 if (err) throw err;
            //                 if (rows && rows.length) {
            //                     message.delete();
            //                     awaitingConfirmationPaypalChannel.send("<@" + messageAuthor + ">" + " You already have a pending payment, wait for reseller to verify payment");
            //                 } else {
            //                     message.delete();
            //                     try {
            //                         var DecodedUsername = utf8.decode(messageAuthor.username);
            //                         var sqlInsertArgs = {name: DecodedUsername, email: email, status: 'Pending', subtype: subPrice, date: dateTime, discordToken: discordToken};
            //                         con.query("INSERT INTO payments_paypal SET ?", sqlInsertArgs, (err, rows) => {
            //                             if (err) throw err;
            //                         });
            //                         awaitingConfirmationPaypalChannel.send("<@" + messageAuthor + ">" + "Payment created, check DM(Message from CPBOT) for additional payment details to sent the transaction. \nOur reseller will verify as soon as possible");
            //                         message.author.send("ferry.kewitzki@gmail.com " + subPrice +" eur, please include your discord name + # (sent as F&F) (Be aware that Paypal might charge Fee's)")
            //                         verificationPaypalChannel.send("New Order: \n" + "Discord Name: " + messageAuthor.username + "\n" + "Email: " + email + "\n" + "Pricing: €" + subPrice  + "\n" + "Date: " + dateTime + "\n" + "Status: Pending");
            //                         ferryKe.send("Received payment from: \n" + messageAuthor.username + "\n" + "With email: \n" + email + "\n" + "Amount: \n" + "€"+subPrice);
            //                     } catch (e) {
            //                         var DecodedUsername = messageAuthor.id;
            //                         var sqlInsertArgs = {name: DecodedUsername, email: email, status: 'Pending', subtype: subPrice, date: dateTime, discordToken: discordToken};
            //                         con.query("INSERT INTO payments_paypal SET ?", sqlInsertArgs, (err, rows) => {
            //                             if (err) throw err;
            //                         });
            //                         awaitingConfirmationPaypalChannel.send("<@" + messageAuthor + ">" + "Payment created, check DM(Message from CPBOT) for additional payment details to sent the transaction. \nOur reseller will verify as soon as possible");
            //                         message.author.send("ferry.kewitzki@gmail.com " + subPrice +" eur, please include your discord name + # (sent as F&F) (Be aware that Paypal might charge Fee's)")
            //                         verificationPaypalChannel.send("New Order: \n" + "Discord Name: " + messageAuthor.username + "\n" + "Email: " + email + "\n" + "Pricing: €" + subPrice  + "\n" + "Date: " + dateTime + "\n" + "Status: Pending");
            //                         ferryKe.send("Received payment from: \n" + messageAuthor.username + "\n" + "With email: \n" + email + "\n" + "Amount: \n" + "€"+subPrice);
            //                     }
            //                 }
            //             });
            //         }
            //     }
            // break;

            default:
                message.delete();
            break;
        }
    }catch(e) {
        console.log(e)
        throw e;
    }
} else {
    if (message.channel.id == "621401219184984095") { 
        message.delete();
    }
    if (message.channel.id == "852482184211464233" || message.channel.id == "852869080523210762") {
        if (message.channel.id == "852869080523210762") {
            if (!message.author.bot) {
                message.delete();
            }
        } else {
            message.delete();
        }
    }
}
});
client.login(config.discordToken);