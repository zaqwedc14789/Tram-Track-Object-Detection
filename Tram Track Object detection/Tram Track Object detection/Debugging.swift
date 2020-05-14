//
//  Debugging.swift
//  Tram Track Object detection
//
//  Created by Lam Kenneth on 13/2/2020.
//  Copyright © 2020 FYP. All rights reserved.
//

import Foundation

public enum YOLOError : Error {
  case modelFileNotFound
  case modelCreationError
  case pixelBufferError
  case noModel
  case strideOutOfBounds
  case unknownError
}

extension YOLOError: LocalizedError {
  public var errorDescription: String? {
    switch self {
    case .modelFileNotFound:
      return "Model file not found"
    case .modelCreationError:
      return "Failed to create model"
    case .pixelBufferError:
      return "Failed to create pixe buffer"
    case .noModel:
      return "No model provided"
    case .strideOutOfBounds:
      return "Stride array Out Of Bounds"
    case .unknownError:
      return "Some unknown error"
    }
  }
}
