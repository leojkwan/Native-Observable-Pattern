import Foundation
import RxSwift

class ReactiveViewController: UIViewController {
  
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let names = Variable(["Leo"])
    names.asObservable().subscribe { (disposable) in
      print(disposable)
      print(disposable.element ?? "-")
      }
      .addDisposableTo(disposeBag)
    
    names.value.append("John")
    
  }
}
