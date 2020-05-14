//
//  BoundingBox.swift
//  Tram Track Object detection
//
//  Created by Lam Kenneth on 13/2/2020.
//  Copyright © 2020 FYP. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class PredictionLayer {
  
  struct Transform {
    var ratioX: CGFloat
    var ratioY: CGFloat
    var addX: CGFloat
    var addY: CGFloat
  }
  
  struct BoundingBox {

    let layer = CAShapeLayer()
    let textLayer = CATextLayer()

    init (predRect: CGRect, transform: Transform,
          label: String, confidence: Float,
          color: CGColor) {
      layer.fillColor = UIColor.clear.cgColor
      layer.lineWidth = 2
      let rect = CGRect(x: predRect.origin.x / transform.ratioX + transform.addX,
                        y: predRect.origin.y / transform.ratioY + transform.addY,
                        width: predRect.width / transform.ratioX,
                        height: predRect.height / transform.ratioY)
      let path = UIBezierPath(rect: rect)
      layer.path = path.cgPath
      layer.strokeColor = color
      
      textLayer.foregroundColor = UIColor.black.cgColor
      textLayer.contentsScale = UIScreen.main.scale
      textLayer.fontSize = 9
      textLayer.font = UIFont(name: "Avenir", size: textLayer.fontSize)
      textLayer.alignmentMode = CATextLayerAlignmentMode.left
      textLayer.frame = CGRect(x: rect.origin.x - 1, y: rect.origin.y - 13,
                               width: 80, height: 14)
      textLayer.backgroundColor = color
      textLayer.string = "\(label):" + String(format: "%.2f", confidence)
    }
    
    func addTo(layer: CALayer) {
      layer.addSublayer(self.layer)
      layer.addSublayer(self.textLayer)
    }
  }
  
  private let layer: CAShapeLayer
  private let tramtracklayer:CAShapeLayer
  private var imageRect: CGRect?
  private var transform = Transform(ratioX: 1,
                                    ratioY: 1,
                                    addX: 0,
                                    addY: 0)
  
  init() {
    layer = CAShapeLayer()
    layer.fillColor = UIColor.clear.cgColor
    layer.isHidden = true
    tramtracklayer = CAShapeLayer()
    tramtracklayer.frame = CGRect(x: 90, y: 50, width: 120, height: 450)
//    tramtracklayer.frame = CGRect(x: 90, y: 250, width: 100, height: 250)  // Tram Track Box Size
    tramtracklayer.fillColor = UIColor.clear.cgColor
    tramtracklayer.lineWidth = 2
    tramtracklayer.strokeColor = UIColor.clear.cgColor
    let path = UIBezierPath(rect: tramtracklayer.frame)
    tramtracklayer.path = path.cgPath
    
  }

  func update(imageViewFrame: CGRect, imageSize: CGSize) {
    let ratio = fmin(imageViewFrame.width / imageSize.width,
                 imageViewFrame.height / imageSize.height)
    imageRect = CGRect(x: 0, y: 0, width: imageSize.width * ratio,
                       height: imageSize.height * ratio)
    imageRect!.origin.y = imageViewFrame.height / 2 - imageRect!.height / 2
    imageRect!.origin.x = imageViewFrame.width / 2 - imageRect!.width / 2
    transform.ratioX = CGFloat(YOLO.inputSize) / imageRect!.width
    transform.ratioY = CGFloat(YOLO.inputSize) / imageRect!.height
    transform.addX = imageRect!.origin.x
    transform.addY = imageRect!.origin.y
  }
  
  func addToParentLayer(_ parent: CALayer) {
    parent.addSublayer(tramtracklayer) // Add tram track box
    parent.addSublayer(layer)
  }
  
  func addBoundingBoxes(predictions: [YOLO.Prediction]) {
    for prediction in predictions {
      let boundingBox = BoundingBox(predRect: prediction.rect,
                                    transform: transform,
                                    label: labels[prediction.classIndex],
                                    confidence: prediction.score,
                                    color: ColorPallete.shared.colors[prediction.classIndex])
      boundingBox.addTo(layer: layer)
    }
  }
    func checkoverlaptramtrack(predictions: [YOLO.Prediction]){
        var flag:Bool = false
        for prediction in predictions {
            flag = tramtracklayer.frame.intersects(prediction.rect)
//            flag = prediction.rect.intersects(tramtracklayer.frame)
            if flag {
                AudioServicesPlayAlertSound(SystemSoundID(1304))
//                print("Alarm!")
                break
            }
        }
    }
    
  func show() {
    layer.isHidden = false
  }
  
  func hide() {
    layer.isHidden = true
  }
  
  func clear() {
    layer.sublayers = nil
  }

}
