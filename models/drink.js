(function () {
	'use strict';

	var mongoose = require('mongoose'),
		drinkSchema = new mongoose.Schema ({
			alcohol_content : {
				type: Number,
				unique: false,
				required: true
			}, 
			description : {
				type: String,
				unique: false,
				required: false
			}, 
			id : {
				type: Number,
				unique: true,
				required: true
			}, 
			is_dead : {
				type: Boolean,
				unique: false,
				required: true
			},
			is_discontinued : {
				type: Boolean,
				unique: false,
				required: true
			},
			name : {
				type: String,
				unique: false,
				required: true
			}, 
			origin : {
				type: String,
				unique: false,
				required: true
			},
			package_unit_type : {
				type: String,
				unique: false,
				required: false
			},
			package_unit_volume_in_milliliters : {
				type: Number,
				unique: false,
				required: true
			},
			price_in_cents : {
				type: Number,
				unique: false,
				required: true
			},
			price_per_liter_of_alcohol_in_cents : {
				type: Number,
				unique: false,
				required: true
			},
			primary_category : {
				type: String,
				unique: false,
				required: true
			},
			image_url : {
				type: String,
				unique: false,
				required: false
			},
			image_thumb_url : {
				type: String,
				unique: false,
				required: false
			},
			tags : {
				type: String,
				unique: false,
				required: true
			}
		});
	module.exports = mongoose.model('Drink', drinkSchema);
}());
