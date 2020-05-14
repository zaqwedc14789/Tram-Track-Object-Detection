//
//  Settings.swift
//  Tram Track Object detection
//
//  Created by Lam Kenneth on 13/2/2020.
//  Copyright © 2020 FYP. All rights reserved.
//

import Foundation

private let defaultModel = YOLOType.v3_416
private let defaultIOUThreshold: Float = 0.5
private let defaultConfidenceThreshold: Float = 0.6
private let defaultIsSmoothed = true

protocol SettingsDelegate: class {
  func reloadingFinished()
}


class Settings {
  
  static let shared = Settings()
  
  var confidenceThreshold: Float
  var iouThreshold: Float
  var modelType: YOLOType
  var isSmoothed: Bool
  
  weak var delegate: SettingsDelegate?
  
  private weak var modelSelection: ModelSelection?
  
  init() {
    confidenceThreshold = defaultConfidenceThreshold
    iouThreshold = defaultIOUThreshold
    modelType = defaultModel
    isSmoothed = defaultIsSmoothed
  }
  
  func save(modelType: YOLOType) -> Bool {
    ModelSelection.shared.model.confidenceThreshold = confidenceThreshold
    ModelSelection.shared.model.iouThreshold = iouThreshold
    if modelType == self.modelType {
      return false
    } else {
      self.modelType = modelType
      DispatchQueue.global().async {
        ModelSelection.shared.reloadModel(type: self.modelType)
        DispatchQueue.main.async {
          guard let delegate = self.delegate else {
            return
          }
          delegate.reloadingFinished()
        }
      }
      return true
    }
  }
  
  func restore() {
    confidenceThreshold = defaultConfidenceThreshold
    iouThreshold = defaultIOUThreshold
    modelType = defaultModel
    isSmoothed = defaultIsSmoothed
  }
  
}
