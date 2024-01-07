//
//  CategoryListViewController.swift
//  
//
//  Created by 이상헌 on 12/31/23.
//

import UIKit

import RIBs
import RxSwift

import SharedUI
import AppFoundation

// MARK: - CategoryListPresentableListener

public protocol CategoryListPresentableListener: AnyObject {
  var error: Observable<DisplayErrorMessage> { get }
  var viewModel: Observable<CategoryListViewModel> { get }
  func loadData()
}

// MARK: - CategoryListViewController

final class CategoryListViewController:
  BaseViewController,
  CategoryListPresentable,
  CategoryListViewControllable,
  HasTableView,
  ErrorAlertable
{

  // MARK: - Constants
  
  private enum Metric {
    static let categoryCreationLabelTopMargin: CGFloat = 18
    static let categoryCreationLabelTrailingMargin: CGFloat = 24
    static let tableViewHeight: CGFloat = 56
  }
  
  // MARK: - Properties
  
  weak var listener: CategoryListPresentableListener?
  
  // MARK: - UI Components
  
  private lazy var categoryCreationLabel = UILabel().builder
    .text("+ 카테고리 생성")
    .textColor(.pointGreen)
    .font(.custom(.bold, 16))
    .build()
  
  let tableView = UITableView().builder
    .backgroundColor(.clear)
    .rowHeight(Metric.tableViewHeight)
    .separatorStyle(.none)
    .with {
      $0.register(CategoryListCell.self)
    }
    .build()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    bindAction()
    bindState()
  }
}

// MARK: - Bind Action

extension CategoryListViewController {
  private func bindAction() {
    bindLoadData()
  }
  
  private func bindLoadData() {
    rx.viewWillAppear
      .throttle(.seconds(1), latest: false, scheduler: MainScheduler.instance)
      .subscribe(with: self) { owner, _ in
        owner.listener?.loadData()
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Bind State

extension CategoryListViewController {
  private func bindState() {
    bindError()
    bindViewModel()
  }
  
  private func bindError() {
    listener?.error
      .asDriver(onErrorDriveWith: .empty())
      .drive(with: self) { owner, error in
        owner.showErrorAlert(with: error)
      }
      .disposed(by: disposeBag)
  }
  
  private func bindViewModel() {
    listener?.viewModel
      .skip(1)
      .observe(on: MainScheduler.instance)
      .compactMap(\.sections.first?.items)
      .bind(to: tableView.rx.items) { tableView, index, item -> UITableViewCell in
        let cell = tableView.dequeue(CategoryListCell.self, indexPath: .init(row: index, section: 0))
        switch item {
        case let .list(item):
          cell.configure(item)
        }
        return cell
      }
      .disposed(by: disposeBag)
  }
}

// MARK: - Layout

extension CategoryListViewController {
  private func setupUI() {
    view.backgroundColor = .black100
    view.addSubview(categoryCreationLabel)
    view.addSubview(tableView)
    
    layout()
  }
  
  private func layout() {
    makeCategoryCreationLabelConstraints()
    makeTableViewConstraints()
  }
  
  private func makeCategoryCreationLabelConstraints() {
    categoryCreationLabel.snp.makeConstraints {
      $0.top.equalToSuperview().offset(Metric.categoryCreationLabelTopMargin)
      $0.trailing.equalToSuperview().offset(-Metric.categoryCreationLabelTrailingMargin)
    }
  }
  
  private func makeTableViewConstraints() {
    tableView.snp.makeConstraints {
      $0.top.equalTo(categoryCreationLabel.snp.bottom)
      $0.leading.bottom.trailing.equalToSuperview()
    }
  }
}

#if DEBUG
@available(iOS 17.0, *)
#Preview("UIKit Portrait") {
  CategoryListViewController()
}
#endif
