//
//  Producto.swift
//  LiverpoolTest
//
//  Created by Eon Igniting on 19/06/21.
//

import Foundation
import UIKit

struct Producto : Decodable {
    
    var smImage : String
    var productDisplayName : String
    var maximumListPrice : Float
    var maximumPromoPrice : Float
    var variantsColor : [Color]?
    
}
