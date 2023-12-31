//
//
//  Created by sangheon on 2023/04/16.
//

import RxSwift

public protocol HasViewModel {
  associatedtype ViewModel
  var viewModel: Observable<ViewModel> { get }
}
