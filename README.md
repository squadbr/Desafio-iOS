# Squad BR challenge - Xcode 9.4.1 / Swift 4.1

Para este desafio você terá que consumir a API da OMDB (http://www.omdbapi.com/) e apresentar o resultado em uma lista.

# Podfile - run pod install version 1.4.0
```<swift>
platform :ios, '11.0'
use_frameworks!
workspace 'DBMovieApp.xcworkspace'

target 'DBMovieApp' do
  
  pod 'lottie-ios'
  pod 'R.swift'
  pod 'ReachabilitySwift'
  pod 'Fabric'
  pod 'Crashlytics'    
  pod 'SwiftyJSON', '~> 4.0'
  pod 'Alamofire', '~> 4.7'
  pod 'Kingfisher'

  target 'DBMovieAppTests' do
    inherit! :search_paths
  end

  target 'DBMovieAppUITests' do
    inherit! :search_paths
  end

end

target 'DBMovieApi' do
    project 'DBMovieApi/DBMovieApi.xcodeproj'
    pod 'SwiftyJSON', '~> 4.0'
    pod 'Alamofire', '~> 4.7'
end

```

# Arquitetura MVC - (LAYERS)

Utilizei MVC com as camadas Infrastructure, Manager, Business e Provider a fim de abstrair toda a parte do API deixando todas as camadas mais clean. Separei o projeto junto a dois frameworks no workspace sendo eles "DBMovieApi" e "DBMovieSupport".

<img src="" width="320"/>

# Infrastructure:
  "Strings", "Plist", "Storyboard" e "Resources"

# ViewController:
  Esta camada atua como uma intermediária entre as camadas View e Manager, ela é reponsável por notificar as Views sobre eventuais mudanças de modelos e vice-versa, ainda nesta camada faço algumas tratativas de eventos, tais como: IBActions e Delegates/DataSources.
  
# View:
  Responsável por toda parte de apresentação, animação a regras de view. Para abstrair um pouco e deixar mais organizado mantenho todos os IBOutlets aqui ele eles são acessados direto pela controller:
```<swift>
    fileprivate var mainView: DBFeedView {
        return self.view as! DBFeedView
    }
```

# Manager:
  Nesta camada controlo o fluxo de requisições entre a camada ViewController e Business. Ela é exclusivamente chamada pela camada ViewController como uma interface.
```<swift>
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            _ = DBManager.shared.rx_fetchAllPopularMovies("\(self.currentPg)", completion: { result in
                if let `_mov` = result?.first { self.allPopularMovies(with: _mov) }
                DispatchQueue.main.async {
                    self.mainView.collectionView.reloadData()
                }
            })
        }
```

```<swift>
public class DBManager: DBManagerProtocol {
    
    public static let shared = DBManager()
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - completion: <#completion description#>
    public func rx_fetchAllPopularMovies(_ page: String?, completion: @escaping DBManagerPopularCallback) {
        DBBusiness.shared.rx_fetchAllPopularMovies(page, nil, completion: completion)
    }
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - name: <#name description#>
    ///   - completion: <#completion description#>
    public func rx_fetchSearchingMovies(_ page: String?, _ name: String?, completion: @escaping DBManagerSearchingCallback) {
        DBBusiness.shared.rx_fetchAllPopularMovies(page, name, completion: completion)
    }
}

```

# Business:
  Esta é uma das mais importantes camadas do aplicativo, aqui é onde comtém estruturas internas responsáveis por todas as regras de negócio. Ela deve ser exclusivamente acessada pela camada Manager e invocar a camada Provider (quando necessário). Ainda nesta camada, é onde recebo os "dados primitivos" (ex:. Data?, Dictionary?) e criá-los em modelos através da realização do parse.
```<swift>
import SwiftyJSON

public class DBBusiness: DBBusinessProtocol {
    
    public static let shared = DBBusiness()
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - completion: <#completion description#>
    func rx_fetchAllPopularMovies(_ page: String?, _ name: String?, completion: @escaping DBBusinessPopularCallback) {
        _ = DBProvider.shared.rx_fetchAllPopularMovies(page, name, completion: { value in
            guard let `JSONValue` = value else { return completion(nil) }
            
            let _mov = DBMovieModel(
                page:           JSONValue[DBMovieModel.key_page].intValue,
                total_results:  JSONValue[DBMovieModel.key_total_results].intValue,
                total_pages:    JSONValue[DBMovieModel.key_total_pages].intValue,
                results:        JSONValue[DBMovieModel.key_results].arrayValue.map { value in
                    return DBMovieResult(
                        vote_count:          value[DBMovieResult.key_vote_count].intValue,
                        id:                  value[DBMovieResult.key_id].intValue,
                        video:               value[DBMovieResult.key_video].boolValue,
                        vote_average:        value[DBMovieResult.key_vote_average].doubleValue,
                        title:               value[DBMovieResult.key_title].stringValue,
                        popularity:          value[DBMovieResult.key_popularity].doubleValue,
                        poster_path:         value[DBMovieResult.key_poster_path].stringValue,
                        original_language:   value[DBMovieResult.key_original_language].stringValue,
                        original_title:      value[DBMovieResult.key_original_title].stringValue,
                        genre_ids:           value[DBMovieResult.key_genre_ids].arrayValue.map { return $0.intValue },
                        backdrop_path:       value[DBMovieResult.key_backdrop_path].stringValue,
                        adult:               value[DBMovieResult.key_adult].boolValue,
                        overview:            value[DBMovieResult.key_overview].stringValue,
                        release_date:        value[DBMovieResult.key_release_date].stringValue)
            })
            completion([_mov])
        })
    }
}

```

# Provider: 
  É responsável pela abstração das camadas da aplicação com acesso às fontes de dados e biblioteca de terceiros. Aqui deve sempre retornar tipos de "dados primitivos", e ser exclusivamente acessada pelo "Business".
```<swift>
import SwiftyJSON
import Alamofire

public class DBProvider: DBProviderProtocol {
    
    public static let shared = DBProvider()
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - page: <#page description#>
    ///   - completion: <#completion description#>
    func rx_fetchAllPopularMovies(_ page: String?, _ name: String?, completion: @escaping DBProviderPopularCallback) {
        if let `pg` = page, !pg.isEmpty, let `n` = name, !n.isEmpty {
            rx_callApi(with: DBServiceApi.shared.loadUrlSearching(with: pg, name: n)) { _JSON in
                completion(_JSON)
            }
        } else if let `pg` = page, !pg.isEmpty {
            rx_callApi(with: DBServiceApi.shared.loadUrlPopular(with: pg)) { _JSON in
                completion(_JSON)
            }
        }
    }
}

extension DBProvider {
    
    /// <#Description#>
    ///
    /// - Parameters:
    ///   - url: <#url description#>
    ///   - completion: <#completion description#>
    fileprivate func rx_callApi(with url: URL, completion: @escaping (_ data: JSON?) -> ()) {
        Alamofire.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                completion(json)
            case .failure(_):
                completion(nil)
            }
        }
    }
}
```

# R.swift
Utilizei "R.swift" para realizar o autocomplete de recursos como: images, fonts, identifiers, 
segues e assim por diante. Este framework é muito útil para manter a organização do projeto como um todo.
<img src="" width="320"/>

# Fabric (Crashlytics)
<img src="" width="320"/>

# Aplicação (app Versão= 1.0.0 Build= 0.0.2):

- Abaixo algumas imagens do app.
- OBS: Na pasta imagens que se encontra na raiz, possuem imagens e vídeos do projeto.

# Icon
<img src="" width="100"/>

# Movies (Popular) List (Collection View)
<img src="" width="320"/>
<img src="" width="320"/>
<img src="" width="320"/>

# Deatils
<img src="" width="320"/>

# My Profile (RESUME):
I've been spending my time with a lot of contents that involve technologies because I breathe this kind of topic, I have more than six (7) years of experience in iOS development and I don't stop of growing my knowledge in this field. I'm passionate about Apple devices and so on.

I'm very proactive, dynamic and hardworking (of course).

- Linkedin:</br>
https://www.linkedin.com/in/felipesantolim
</br></br>
- Apps on App Store:</br>
https://itunes.apple.com/us/app/meme-maker-plus/id1380190429?mt=8 </br>
https://itunes.apple.com/us/app/fipe/id1374656563?mt=8 </br>
https://itunes.apple.com/us/app/pacote-fácil/id1382473900?mt=8 
</br></br>
- Cocoacontrols:</br>
https://www.cocoacontrols.com/controls/shfsignature

# O que eu faria com mais tempo?

- Splashscreen
- //TODO: Alert without internet
- //TODO: loadview
- Implementaria extensions para UIColor.
- Faria o uso de "Fakery" para cirar mocks precisos quando rodarmos em um 
  ambiente de teste, garantindo a integridade e funcionalidade da camada de apresentação.
- Adicionaria testes de UI.
- Adicionaria testes unitários.
