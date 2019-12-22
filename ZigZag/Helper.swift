//
//  Helper.swift
//  ZigZag
//
//  Created by Даниленко Данила Сергеевич on 18.12.2019.
//  Copyright © 2019 Даниленко Данила Сергеевич. All rights reserved.
//

import Foundation
import UIKit

enum UIUserInterfaceIdiom : Int {
    case unspecified
    case phone
    case pad
}

func getCef()->CGFloat{
    let deviceIdiom = UIScreen.main.traitCollection.userInterfaceIdiom
    
    switch (deviceIdiom) {
    case .pad:
        return 8
    case .phone:
        return 6
    default:
        return 6
    }
}

public class Helper {
    static let shared = Helper()

    enum constaintsEnum {
           case blockSize
           case smallBlockSize
       }
       
       struct constaints {
           let smallBlockSize = Int(UIScreen.main.bounds.width/2/getCef())
           let blockSize = Int(UIScreen.main.bounds.width/getCef())
       }
       
       func getConstaint(key: constaintsEnum) -> Int {
           switch key {
           case .blockSize:
               return constaints().blockSize
           case .smallBlockSize:
               return constaints().smallBlockSize
           }
       }
}
