import Foundation


protocol Disposable {
  func dispose()
}

extension Disposable {
  func disposed(by bag: MyDisposeBag) {
    bag.add(self)
  }
}

class ObserverDisposable<T>: Disposable {
  
  var key: Int
  weak var owner: Observable<T>?
  
  init(owner: Observable<T>, key: Int) {
    self.owner = owner
    self.key = key
  }
  
  func dispose() {
    self.owner?.removeObserver(with: key)
  }
}

class MyDisposeBag {
  
  var disposables: [Disposable] = []
  
  func add(_ disposable: Disposable) {
    disposables.append(disposable)
    print("new dispose bag count: \(disposables.count)")
  }
  
  func dispose() {
    disposables.forEach({$0.dispose()})
  }
  
  // When our view controller deinits, our dispose bag will deinit as well
  // and trigger the disposal of all corresponding observers living in the
  // Observable, which Disposable has a weak reference to: 'owner'.
  deinit {
    dispose()
  }
}
