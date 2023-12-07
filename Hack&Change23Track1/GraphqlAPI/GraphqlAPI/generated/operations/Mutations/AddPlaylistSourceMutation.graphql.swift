// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class AddPlaylistSourceMutation: GraphQLMutation {
  static let operationName: String = "AddPlaylistSource"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddPlaylistSource($roomId: String!, $sourceUrl: String!) { AddPlaylistSource(RoomId: $roomId, SourceUrl: $sourceUrl) { __typename ...SourceAttrs } }"#,
      fragments: [SourceAttrs.self]
    ))

  public var roomId: String
  public var sourceUrl: String

  public init(
    roomId: String,
    sourceUrl: String
  ) {
    self.roomId = roomId
    self.sourceUrl = sourceUrl
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "sourceUrl": sourceUrl
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("AddPlaylistSource", [AddPlaylistSource?]?.self, arguments: [
        "RoomId": .variable("roomId"),
        "SourceUrl": .variable("sourceUrl")
      ]),
    ] }

    var addPlaylistSource: [AddPlaylistSource?]? { __data["AddPlaylistSource"] }

    init(
      addPlaylistSource: [AddPlaylistSource?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootMutationType.typename,
          "AddPlaylistSource": addPlaylistSource._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(AddPlaylistSourceMutation.Data.self)
        ]
      ))
    }

    /// AddPlaylistSource
    ///
    /// Parent Type: `Source`
    struct AddPlaylistSource: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(SourceAttrs.self),
      ] }

      var name: String? { __data["Name"] }
      var id: String? { __data["Id"] }
      var cover: String? { __data["Cover"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var sourceAttrs: SourceAttrs { _toFragment() }
      }

      init(
        name: String? = nil,
        id: String? = nil,
        cover: String? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Source.typename,
            "Name": name,
            "Id": id,
            "Cover": cover,
          ],
          fulfilledFragments: [
            ObjectIdentifier(AddPlaylistSourceMutation.Data.AddPlaylistSource.self),
            ObjectIdentifier(SourceAttrs.self)
          ]
        ))
      }
    }
  }
}
