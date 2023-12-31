//
//  ColorPickerBuilder.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import RIBs

import ColorPicker

// MARK: - ColorPickerDependency

public protocol ColorPickerDependency: Dependency {
  
}

// MARK: - ColorPickerComponent

final class ColorPickerComponent: Component<ColorPickerDependency> {
  
}

// MARK: - ColorPickerBuilder

public final class ColorPickerBuilder:
  Builder<ColorPickerDependency>,
  ColorPickerBuildable
{
  
  public override init(dependency: ColorPickerDependency) {
    super.init(dependency: dependency)
  }
  
  public func build(withListener listener: ColorPickerListener) -> ColorPickerRouting {
    let component = ColorPickerComponent(dependency: dependency)
    let viewController = ColorPickerViewController()
    let interactor = ColorPickerInteractor(presenter: viewController)
    interactor.listener = listener
    return ColorPickerRouter(
      interactor: interactor,
      viewController: viewController
    )
  }
}
