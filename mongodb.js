(function () {
	'use strict';

	var mongodb = require('mongodb'),
		mongoose = require('mongoose'),
		q = require('q'),
		waterfall = require('async-waterfall'),

		db = mongoose.connection,

		http = require('http'),
		https = require('https'),

		Drink = require('./models/drink');

	db.on('error', console.error);

	db.once('open', function () {
		exports.saveDrinks = function(pages) {
			console.log('starting save');
			waterfall([
				function(callback) {
					//Delete all the drink info before saving new info.
					db.collection('drinks').deleteMany( {}, function(err, results) {
						console.log('Database cleared')
						callback(null);
					});
				}, function (callback) {
					function drinkSaveToDB (drink) {

		            var deferred = q.defer();

		            drink.save(function (err) {
		                if (err === undefined || err === null) {
		                    deferred.resolve(drink);
		                } else {
		                    console.log('Error saving drink to database: ' + err);
		                    deferred.reject(err);
		                }
		            });

			            return deferred.promise;
			        }
					for (var i = 0; i < pages.length; i++) {
						var page = pages[i];
						for (var j = 0; j < page.result.length; j++) {
							var result = page.result[j];
							
							//Only save drink if it still exists
							if(!result.is_dead && !result.is_discontinued) {
								var drink = new Drink({
									alcohol_content: result.alcohol_content,
									description: result.description,
									id: result.id,
									is_dead: result.is_dead,
									is_discontinued: result.is_discontinued,
									name: result.name,
									origin: result.origin,
									package_unit_type: result.package_unit_type,
									package_unit_volume_in_milliliters: result.package_unit_volume_in_milliliters,
									price_in_cents: result.price_in_cents,
									price_per_liter_of_alcohol_in_cents: result.price_per_liter_of_alcohol_in_cents,
									primary_category: result.primary_category,
									image_url: result.image_url,
									image_thumb_url: result.image_thumb_url,
									tags: result.tags
								});

								drinkSaveToDB(drink).then(function () {
									next()
								}, function (err) {
									console.log('Error saving drink: ' + err);
			                		next(err);
								});
							}
						}
					}
					callback(null);
				}, function (callback) {
					console.log('Done with save operations');
				}
			])
		};

		exports.getDrinksForPrice = function(req, res, price) {
			Drink.find({'price_in_cents': price}, function(err, drinks) {
				if (!err) {
					res.json(drinks).status(200);
				}
			});
		};

		exports.getDrinksGreaterThanPrice = function(price) {
			Drink.find({'price_in_cents': {$gt: price}}, function(err, drinks) {
				if (!err) {
					return drinks;
				}
			});
		};

		exports.getDrinksLessThanPrice = function(price) {
			Drink.find({'price_in_cents': {$lt: price}}, function(err, drinks) {
				if (!err) {
					return drinks;
				}
			});
		};

		exports.getDrinksForPriceRange = function(low, high) {
			Drink.find({'price_in_cents': {$lt: high, $gt: low}}, function(err, drinks) {
				if (!err) {
					return drinks;
				}
			});			
		};
		
	});

	mongoose.connect('mongodb://localhost/turnup');
}());