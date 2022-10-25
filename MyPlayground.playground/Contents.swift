import UIKit
import RxSwift

example(of: "just, of, from") {
    // 1
    let one = 1
    let two = 2
    let three = 3

    // 2
    let _ = Observable<Int>.just(one)
    let _ = Observable.of(one, two, three)
    let _ = Observable.of([one, two, three])
    let _ = Observable.from([one, two, three])


}

example(of: "subscribe") {
    let one = 1
    let two = 2
    let three = 3

    let observable = Observable.of(one, two, three)
    observable.subscribe(onNext: { element in
      print(element)
    })
}

example(of: "empty") {
  let observable = Observable<Void>.empty()
    observable.subscribe(
      // 1
      onNext: { element in
        print(element)
      },

      // 2
      onCompleted: {
        print("Completed")
      }
    )
}

example(of: "never") {
  let observable = Observable<Void>.never()

  observable.subscribe(
    onNext: { element in
      print(element)
    },
    onCompleted: {
      print("Completed")
    }
  )
}

example(of: "range") {
  // 1
  let observable = Observable<Int>.range(start: 1, count: 10)

  observable
    .subscribe(onNext: { i in
      // 2
      let n = Double(i)

      let fibonacci = Int(
        ((pow(1.61803, n) - pow(0.61803, n)) /
          2.23606).rounded()
      )

      print(fibonacci)
  })
}



