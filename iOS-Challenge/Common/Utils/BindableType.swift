//
//  BindableType.swift
//  iOS-Challenge
//
//  Created by Alejandro Ulloa on 2022-02-02.
//

import UIKit

protocol BindableType: AnyObject {
  
  associatedtype ViewModelType
  
  var viewModel: ViewModelType! { get set }
  
  func setUpViews()
  func setUpLabels()
  func setUpConstraints()
  func bindViewModel()
  
}

extension BindableType where Self: UIViewController {
  func bind(to viewModel: Self.ViewModelType) {
    self.viewModel = viewModel
    loadViewIfNeeded()
    setUpViews()
    setUpLabels()
    setUpConstraints()
    bindViewModel()
  }
}
