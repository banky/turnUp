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
    var id: String
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
    init?(info:NSDictionary) {
        self.alcoholContent = info["alcohol_content"] as! Double
        self.description = info["description"] as? String
        self.id = info["_id"] as! String
        self.is_dead = info["is_dead"] as! Bool
        self.is_discontinued = info["is_discontinued"] as! Bool
        self.name = info["name"] as! String
        self.origin = info["origin"] as! String
        self.package_unit_type = info["package_unit_type"] as? String
        self.package_unit_volume_in_milliliters = info["package_unit_volume_in_milliliters"] as! Double
        self.price_in_cents = info["price_in_cents"] as! Int
        self.price_per_liter_of_alcohol_in_cents = info["price_per_liter_of_alcohol_in_cents"] as! Int
        self.primary_category = info["primary_category"] as! String
        self.image_url = info["image_url"] as? String
        self.image_thumb_url = info["image_thumb_url"] as? String
        self.tags = info["tags"] as! String

        if alcoholContent < 0 || id.isEmpty || name.isEmpty || origin.isEmpty
            || package_unit_volume_in_milliliters < 0 || price_in_cents < 0 || price_per_liter_of_alcohol_in_cents < 0
            || primary_category.isEmpty || tags.isEmpty {
                return nil
        }

    }
}