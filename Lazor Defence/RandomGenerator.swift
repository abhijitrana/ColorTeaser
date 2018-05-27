//
//  RandomGenerator.swift
//  FlappyBlueprint3
//
//  Created by Alex Nagy on 09/09/2016.
//  Copyright © 2016 Rebeloper. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat {
 
  public static func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
  }
  
  public static func random(_ min: CGFloat, max: CGFloat) -> CGFloat {
    return CGFloat.random() * (max - min) + min
  }
  
}
