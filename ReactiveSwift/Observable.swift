import Foundation
import UIKit


class Observable<T> {
  
  typealias Observer = (T) -> Void
  private(set) var observers = [Int: Observer]()
  
  func observe(_ observer: @escaping Observer)-> Disposable {
    
    let uniqueKey = Int(arc4random_uniform(10000))
    
    // add observer to observers
    observers[uniqueKey] = (observer)
    
    print("total observer count: \(observers.keys.count)")
    
    return ObserverDisposable(owner: self, key: uniqueKey)
  }
  
  func updateObservers() {
    for (_, observer) in observers {
      // iterate over all observers,
      // and call closure with new value.
      observer(value)
    }
  }
  
  var value: T {
    didSet {
      updateObservers()
    }
  }
  
  func removeObserver(with key: Int) {
    if observers.keys.contains(key) {
      observers.removeValue(forKey: key)
      updateObservers()
    }
  }
  
  init(_ v: T) {
    value = v
  }
}
