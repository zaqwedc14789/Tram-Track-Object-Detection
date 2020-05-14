//
//  Helpers.swift
//  Tram Track Object detection
//
//  Created by Lam Kenneth on 13/2/2020.
//  Copyright © 2020 FYP. All rights reserved.
//

import Foundation
import UIKit

//let labels = ["person","bike","car","motorbike","aeroplane","bus",
//              "train","truck","boat","traffic light","fire hydrant",
//              "stop sign","parking meter","bench","bird","cat","dog",
//              "horse","sheep","cow","elephant","bear","zebra","giraffe",
//              "backpack","umbrella","handbag","tie","suitcase","frisbee",
//              "skis","snowboard","sports ball","kite","baseball bat",
//              "baseball glove","skateboard","surfboard","tennis racket",
//              "bottle","wine glass","cup","fork","knife","spoon","bowl",
//              "banana","apple","sandwich","orange","broccoli","carrot",
//              "hot dog","pizza","donut","cake","chair","sofa","pottedplant",
//              "bed","diningtable","toilet","tvmonitor","laptop","mouse",
//              "remote","keyboard","cell phone","microwave","oven","toaster",
//              "sink","refrigerator","book","clock","vase","scissors",
//              "teddy bear","hair drier","toothbrush"]

let labels = ["Coin","Drinkingstraw","Pen","Chopsticks","Dice","Spoon","Knife","Scissors","Watch"]  //custom model testing

struct ColorPallete {
    
  static let shared = ColorPallete()
    var colors: [CGColor] = []
//  init() {
//    for r: CGFloat in [0.1, 0.3, 0.5, 0.6, 0.7] {
//      for g: CGFloat in [0.2, 0.3, 0.6, 0.8] {
//        for b: CGFloat in [0.5, 0.7, 0.9, 1.0] {
//            let color = UIColor(red: r, green: g, blue: b, alpha: 1).cgColor
//          colors.append(color)
//        }
//      }
//    }
//  }
    
    init() {                                //custom model testing
      for r: CGFloat in [0.1, 0.3, 0.5] {
        for g: CGFloat in [0.2, 0.3, 0.6] {
          for b: CGFloat in [0.5] {
              let color = UIColor(red: r, green: g, blue: b, alpha: 1).cgColor
            colors.append(color)
          }
        }
      }
    }
  
}

let anchors1_tiny: [Float] = [81,82 , 135,169,  344,319]
let anchors2_tiny: [Float] = [10,14,  23,27,  37,58]

let tiny_anchors = [
  "output1": anchors1_tiny,
  "output2": anchors2_tiny
]

let anchors1: [Float] = [116,90,  156,198,  373,326]
let anchors2: [Float] = [30,61,  62,45,  59,119]
let anchors3: [Float] = [10,13,  16,30,  33,23]

let anchors_416 = [
  "output1": anchors1,
  "output2": anchors2,
  "output3": anchors3
]
