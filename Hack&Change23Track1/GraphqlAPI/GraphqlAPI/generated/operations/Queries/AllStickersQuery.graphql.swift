// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class AllStickersQuery: GraphQLQuery {
  static let operationName: String = "AllStickers"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AllStickers { AllStickers { __typename Stickers } }"#
    ))

  public init() {}

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("AllStickers", [AllSticker?]?.self),
    ] }

    var allStickers: [AllSticker?]? { __data["AllStickers"] }

    init(
      allStickers: [AllSticker?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "AllStickers": allStickers._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(AllStickersQuery.Data.self)
        ]
      ))
    }

    /// AllSticker
    ///
    /// Parent Type: `StickerPack`
    struct AllSticker: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.StickerPack }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("Stickers", [String?]?.self),
      ] }

      var stickers: [String?]? { __data["Stickers"] }

      init(
        stickers: [String?]? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.StickerPack.typename,
            "Stickers": stickers,
          ],
          fulfilledFragments: [
            ObjectIdentifier(AllStickersQuery.Data.AllSticker.self)
          ]
        ))
      }
    }
  }
}
