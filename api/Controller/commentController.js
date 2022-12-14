const Comment = require('../Model/Comment');
const Rate = require('../Model/Rate');
const {logger} = require('../logger/logger');

//------------ Create ------------//
exports.createComment = async(req, res) => {
    try {
        const id_account = req.user.id;
        const urlImage = (req.body.urlImage);
        const content = (req.body.content);
        const id_product = (req.body.id_product);

        const star = (req.body.star);
        var rate = await Rate.findOne({ id_product: id_product });

        if (rate) {
            var sum = rate.sum + star;
            var amount = rate.amount + 1;
            var starRate = sum / amount;
            var rate = await Rate.findByIdAndUpdate(rate.id, {
                rate: starRate,
                sum: sum,
                amount: amount
            });
        } else {
            var newRate = new Rate({
                id_product: id_product,
                rate: star,
                sum: star,
                amount: 1
            });
            newRate = await newRate.save();
        }

        var newComment = new Comment({
            id_account: id_account,
            id_product: id_product,
            urlImage: urlImage,
            content: content,
            star: star
        });
        newComment = await newComment.save();
        res.status(200).json({
            message: "success",
            user: newComment,
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

//------------ update ------------//
exports.updateComment = async(req, res) => {
    try {
        const urlImage = (req.body.urlImage);
        const content = (req.body.content);
        const star = (req.body.star);

        var comment = await Comment.findById(req.params.id);
        var sum = comment.star;

        comment = await Comment.findByIdAndUpdate(req.params.id, {
            urlImage: urlImage,
            content: content,
            star: star
        });
        comment = await Comment.findById(req.params.id);

        var rate = await Rate.findOne({ id_product: comment.id_product });
        var sum = rate.sum + star - sum;
        var amount = rate.amount;
        var starRate = sum / amount;
        var rate = await Rate.findByIdAndUpdate(rate.id, {
            rate: starRate,
            sum: sum
        });


        res.status(200).json({
            message: "success",
            user: comment,
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}

exports.getComment = async function(req, res) {
    try {
        const comment = await Comment.find({ id_product: req.params.id_product })
        res.status(200).json({
            message: "success",
            comment: comment,
            status: true
        });
    } catch (e) {
        res.send(e);
        logger.info(e);
        logger.error(e);
    }
}