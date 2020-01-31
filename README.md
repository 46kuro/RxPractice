# RxPractice
practice to understand RxSwift. 

## Roadmap

### Day1
#### Purpose
* practice RxSwift / RxCocoa in simple view
* understand Observable / Observer / Bind

#### Task
* downloading RxSwift project and start the RxExample-iOS target
  * [Github URL](https://github.com/ReactiveX/RxSwift/tree/master/RxExample)
  * implement examples in this project
    * Adding numbers
      * [Bind](https://qiita.com/usamik26/items/444d6dd7386b2949c06b)
    * Simple validation
      * [shareReplay](https://qiita.com/kazu0620/items/bde4a65e82a10bd33f88)
* watch link article
  * watch [iOSDC Japan 2017 RxSwiftのObservableとは何か](https://www.youtube.com/watch?v=jfIhTUSZfy4&t=974s) and read [What's Observable](https://qiita.com/gomi_ningen/items/c796c08fe672610beecf) to understand Observable / Observer
  * read [RxSwift 再入門](https://qiita.com/usamik26/items/444d6dd7386b2949c06b) to understand Bind / Relay

  
### Day2
#### Purpose
* understand to show async geolocation value

#### Task
* Geolocation Subscription
  * [create / diferred](https://qiita.com/moaible/items/de94c574b25ea4f0ef17)
  * copy CLLocationManager+Rx and RxCLLocationManagerDelegateProxy and implement GeolocaitionService Logic.
    * TODO: Read CLLocationManager+Rx and RxCLLocationManagerDelegateProxy 

### Day3
#### Purpose
* understand simple MVVM example

#### Task
* Implement Github SignUp(Vanilla Observables and Using Driver)
  * flatMapLatest
    * [【Swift】RxSwiftのPlaygroundを読む④](https://qiita.com/KentaKudo/items/7d939b6c05aa7daf9746)
    * switchLatest
      * [RxSwiftの機能カタログ](https://qiita.com/k5n/items/e80ab6bff4bbb170122d)
  * observeOn(MainScheduler.instance)
    * [RxSwiftにおけるマルチスレッドの理解を深める — Schedulerについて](https://medium.com/eureka-engineering/rxswift%E3%81%AB%E3%81%8A%E3%81%91%E3%82%8B%E3%83%9E%E3%83%AB%E3%83%81%E3%82%B9%E3%83%AC%E3%83%83%E3%83%89%E3%81%AE%E7%90%86%E8%A7%A3%E3%82%92%E6%B7%B1%E3%82%81%E3%82%8B-scheduler%E3%81%AB%E3%81%A4%E3%81%84%E3%81%A6-2471ec76e518)
  * how to make Binder
    * [RxSwiftでBindTo可能な独自プロパティを生やす方法](https://blog.a-azarashi.jp/entry/2018/01/13/222537/)

## Understand RxSwift overview
* [Hot / Cold](https://www.slideshare.net/yukitakahashi3139241/hot-cold)
