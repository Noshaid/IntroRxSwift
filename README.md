# IntroRxSwift
Intro to Reactive Programming using **RxSwift** &amp; **RxCocoa**.

Impelment simple TableView using **RxSwift** &amp; **RxCocoa** In this following things used

1. PublishSubject<T>()
2. onNext()
3. onCompleted()
4. DisposeBag()
5. bind()
6. modelSelected()
  
Bind our model array with tableview using **bind** method available in RxCocoa and **modelSelected** method.

## Basic Flow
  - We have items array of type **Product** declared as **PublishSubject<<Product>>()** because this is our observable object
  - TableView is our **Observer** who constantly observe items array. Whenever items array changes tableView automatically updates the UI.
  
