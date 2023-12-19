// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class AddPlaylistSourceMutation: GraphQLMutation {
  static let operationName: String = "AddPlaylistSource"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"mutation AddPlaylistSource($roomId: String!, $url: String!) { AddPlaylistSource(RoomId: $roomId, Url: $url) { __typename ...PlaylistRowAttrs } }"#,
      fragments: [PlaylistRowAttrs.self, SourceAttrs.self]
    ))

  public var roomId: String
  public var url: String

  public init(
    roomId: String,
    url: String
  ) {
    self.roomId = roomId
    self.url = url
  }

  public var __variables: Variables? { [
    "roomId": roomId,
    "url": url
  ] }

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootMutationType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("AddPlaylistSource", [AddPlaylistSource?]?.self, arguments: [
        "RoomId": .variable("roomId"),
        "Url": .variable("url")
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
    /// Parent Type: `PlaylistRow`
    struct AddPlaylistSource: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistRow }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(PlaylistRowAttrs.self),
      ] }

      var id: String { __data["Id"] }
      var index: Int { __data["Index"] }
      var source: Source { __data["Source"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var playlistRowAttrs: PlaylistRowAttrs { _toFragment() }
      }

      init(
        id: String,
        index: Int,
        source: Source
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.PlaylistRow.typename,
            "Id": id,
            "Index": index,
            "Source": source._fieldData,
          ],
          fulfilledFragments: [
            ObjectIdentifier(AddPlaylistSourceMutation.Data.AddPlaylistSource.self),
            ObjectIdentifier(PlaylistRowAttrs.self)
          ]
        ))
      }

      /// AddPlaylistSource.Source
      ///
      /// Parent Type: `Source`
      struct Source: SchemaAPI.SelectionSet {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }

        var id: String { __data["Id"] }
        var cover: String { __data["Cover"] }
        var name: String { __data["Name"] }

        struct Fragments: FragmentContainer {
          let __data: DataDict
          init(_dataDict: DataDict) { __data = _dataDict }

          var sourceAttrs: SourceAttrs { _toFragment() }
        }

        init(
          id: String,
          cover: String,
          name: String
        ) {
          self.init(_dataDict: DataDict(
            data: [
              "__typename": SchemaAPI.Objects.Source.typename,
              "Id": id,
              "Cover": cover,
              "Name": name,
            ],
            fulfilledFragments: [
              ObjectIdentifier(AddPlaylistSourceMutation.Data.AddPlaylistSource.Source.self),
              ObjectIdentifier(SourceAttrs.self),
              ObjectIdentifier(PlaylistRowAttrs.Source.self)
            ]
          ))
        }
      }
    }
  }
}
