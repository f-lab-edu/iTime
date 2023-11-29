//
//  File.swift
//
//
//  Created by 이상헌 on 11/27/23.
//

import UIKit

import RxSwift

import AppFoundation

protocol EndEditingDelegate: DatePickerSectionView {
  func endEditing()
}

final class DatePickerFactory {
  
  private let disposeBag = DisposeBag()
  
  private lazy var startDatePicker = UIDatePicker().builder
    .preferredDatePickerStyle(.wheels)
    .datePickerMode(.date)
    .build()
  
  private lazy var endDatePicker = UIDatePicker().builder
    .preferredDatePickerStyle(.wheels)
    .datePickerMode(.date)
    .build()
  
  private lazy var startTimePicker = UIDatePicker().builder
    .preferredDatePickerStyle(.wheels)
    .datePickerMode(.time)
    .build()
  
  private lazy var endTimePicker = UIDatePicker().builder
    .preferredDatePickerStyle(.wheels)
    .datePickerMode(.time)
    .build()
  
  private let timeFormatter: TimeFormatter
  weak var delegate: EndEditingDelegate?
  
  init(timeFormatter: TimeFormatter) {
    self.timeFormatter = timeFormatter
  }
  
  // MARK: - Private
  
  func setPickersInitalDateInterval() {
    setStartDatePickerMaximumDate()
    setEndDatePickerMinimumDate()
    setStartTimePickerMaximumDate()
    setEndTimePickerMinimumDate()
  }
  
  func setStartDatePickerMaximumDate() {
    startDatePicker.maximumDate = endDatePicker.date
  }
  
  func setEndDatePickerMinimumDate() {
    endDatePicker.minimumDate = startDatePicker.date
  }
  
  func setStartTimePickerMaximumDate() {
    startTimePicker.maximumDate = endTimePicker.date
  }
  
  func setEndTimePickerMinimumDate() {
    endTimePicker.minimumDate = startTimePicker.date
  }
  
  func makeStartDateToolBar(_ textField: UITextField) {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([flexibleSpace, saveButton], animated: true)
    textField.inputAccessoryView = toolbar
    textField.inputView = startDatePicker
    
    saveButton.rx
      .tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        textField.text = owner.timeFormatter.formatToMMDD(date: owner.startDatePicker.date)
        owner.setEndDatePickerMinimumDate()
        owner.delegate?.endEditing()
      }
      .disposed(by: disposeBag)
  }
  
  func makeEndDateToolBar(_ textField: UITextField) {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([flexibleSpace, saveButton], animated: true)
    textField.inputAccessoryView = toolbar
    textField.inputView = endDatePicker
    endDatePicker.minimumDate = startDatePicker.date
    
    saveButton.rx
      .tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        textField.text = owner.timeFormatter.formatToMMDD(date: owner.endDatePicker.date)
        owner.setStartDatePickerMaximumDate()
        owner.delegate?.endEditing()
      }
      .disposed(by: disposeBag)
  }
  
  func makeStartTimeToolbar(_ textField: UITextField) {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([flexibleSpace, saveButton], animated: true)
    textField.inputAccessoryView = toolbar
    textField.inputView = startTimePicker
    startTimePicker.maximumDate = endTimePicker.minimumDate
    
    saveButton.rx
      .tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        textField.text = owner.timeFormatter.formatToHHMM(date: owner.startTimePicker.date)
        owner.setEndTimePickerMinimumDate()
        owner.delegate?.endEditing()
      }
      .disposed(by: disposeBag)
  }
  
  func makeEndTimeToolbar(_ textField: UITextField) {
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: nil, action: nil)
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([flexibleSpace, saveButton], animated: true)
    textField.inputAccessoryView = toolbar
    textField.inputView = endTimePicker
    endTimePicker.minimumDate = startTimePicker.date
    
    saveButton.rx
      .tap
      .preventDuplication()
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, _ in
        textField.text = owner.timeFormatter.formatToHHMM(date: owner.endTimePicker.date)
        owner.setStartTimePickerMaximumDate()
        owner.delegate?.endEditing()
      }
      .disposed(by: disposeBag)
  }
  
}
