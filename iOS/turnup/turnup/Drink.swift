//
//  Drink.swift
//  turnup
//
//  Created by Bankole Adebajo on 2016-03-03.
//  Copyright © 2016 Banky. All rights reserved.
//

import UIKit

class Drink {
    //MARK: Properties
    
    var alcoholContent:Double
    var description: String?
    var id: Int
    var is_dead: Bool
    var is_discontinued: Bool
    var name: String
    var origin: String
    var package_unit_type: String?
    var package_unit_volume_in_milliliters: Double
    var price_in_cents: Int
    var price_per_liter_of_alcohol_in_cents: Int
    var primary_category: String
    var image_url: String?
    var image_thumb_url: String?
    var tags: String
    
    //MARK: Initialization
    
    //Fat initializer
    init?(alcoholContent:Double, description: String?, id: Int,is_dead: Bool,is_discontinued: Bool,
        name: String, origin: String,package_unit_type: String?, package_unit_volume_in_milliliters: Double,
        price_in_cents: Int, price_per_liter_of_alcohol_in_cents: Int, primary_category: String, image_url: String?,
        image_thumb_url: String?, tags: String) {
            
            self.alcoholContent = alcoholContent;
            self.description = description
            self.id = id
            self.is_dead = is_dead
            self.is_discontinued = is_discontinued
            self.name = name
            self.origin = origin
            self.package_unit_type = package_unit_type
            self.package_unit_volume_in_milliliters = package_unit_volume_in_milliliters
            self.price_in_cents = price_in_cents
            self.price_per_liter_of_alcohol_in_cents = price_per_liter_of_alcohol_in_cents
            self.primary_category = primary_category
            self.image_url = image_url
            self.image_thumb_url = image_thumb_url
            self.tags = tags
            
            //Fail if there are any errors
            if alcoholContent < 0 || id < 0 || name.isEmpty || origin.isEmpty
                || package_unit_volume_in_milliliters < 0 || price_in_cents < 0 || price_per_liter_of_alcohol_in_cents < 0
                || primary_category.isEmpty || tags.isEmpty {
                    return nil
            }

    }
    
}