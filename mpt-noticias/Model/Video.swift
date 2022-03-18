//
//  Video.swift
//  mpt-noticias
//
//  Created by Luiz Carlos F Ramos on 09/02/22.
//

import Foundation


class Video {
    
    let title: String
    let previewUrl: String
    let filename: String
    let videoUrl: String
    
    init(item: Item){
        self.title = item.title
        self.previewUrl = item.imagem.scales.preview.download
        self.filename = item.imagem.filename
        self.videoUrl = item.remoteURL
    }
    
}

    // MARK: - Welcome
struct Welcome: Codable {
    let id: String
    let batching: Batching
    let items: [Item]
    let itemsTotal: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case batching, items
        case itemsTotal = "items_total"
    }
}

    // MARK: - Batching
struct Batching: Codable {
    let id, first, last, next: String
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case first, last, next
    }
}

    // MARK: - Item
struct Item: Codable {
    let components: Components
    let id: String
    let type: ItemType
    let uid: String
    let allowDiscussion: Bool
//    let created: Date
    let itemID: String
    let imagem: Imagem
    let isFolderish: Bool
    let layout: Layout
//    let modified: Date
    let parent: Parent
    let remoteURL: String
    let reviewState: ReviewState
    let title: String
    let version: Version
    
    enum CodingKeys: String, CodingKey {
        case components = "@components"
        case id = "@id"
        case type = "@type"
        case uid = "UID"
        case allowDiscussion = "allow_discussion"
//        case created
        case itemID = "id"
        case imagem
        case isFolderish = "is_folderish"
        case layout,  parent
//        case modified
        case remoteURL = "remoteUrl"
        case reviewState = "review_state"
        case title, version
    }
}

    // MARK: - Components
struct Components: Codable {
    let actions, breadcrumbs, navigation, workflow: Actions
}

    // MARK: - Actions
struct Actions: Codable {
    let id: String
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
    }
}

    // MARK: - Imagem
struct Imagem: Codable {
    let contentType: ContentType
    let download: String
    let filename: String
    let height: Int
    let scales: Scales
    let size, width: Int
    
    enum CodingKeys: String, CodingKey {
        case contentType = "content-type"
        case download, filename, height, scales, size, width
    }
}

enum ContentType: String, Codable {
    case imageJPEG = "image/jpeg"
}

    // MARK: - Scales
struct Scales: Codable {
    let campanha, icon, large, listing: Campanha
    let mini, noticia, preview, thumb: Campanha
    let tile: Campanha
}

    // MARK: - Campanha
struct Campanha: Codable {
    let download: String
    let height, width: Int
}

enum Layout: String, Codable {
    case view = "view"
}

    // MARK: - Parent
struct Parent: Codable {
    let id: String
    let type: ParentType
    let parentDescription: String
    let reviewState: ReviewState
    let title: Title
    
    enum CodingKeys: String, CodingKey {
        case id = "@id"
        case type = "@type"
        case parentDescription = "description"
        case reviewState = "review_state"
        case title
    }
}

enum ReviewState: String, Codable {
    case published = "published"
}

enum Title: String, Codable {
    case vídeos = "Vídeos"
}

enum ParentType: String, Codable {
    case folder = "Folder"
}

enum ItemType: String, Codable {
    case video = "video"
}

enum Version: String, Codable {
    case current = "current"
}
