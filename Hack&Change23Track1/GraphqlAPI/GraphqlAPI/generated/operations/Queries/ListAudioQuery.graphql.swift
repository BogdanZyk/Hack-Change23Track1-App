// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class ListAudioQuery: GraphQLQuery {
  static let operationName: String = "ListAudio"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ListAudio { ListAudio { __typename ...FileAttrs } }"#,
      fragments: [FileAttrs.self]
    ))

  public init() {}

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("ListAudio", [ListAudio?]?.self),
    ] }

    var listAudio: [ListAudio?]? { __data["ListAudio"] }

    init(
      listAudio: [ListAudio?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "ListAudio": listAudio._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(ListAudioQuery.Data.self)
        ]
      ))
    }

    /// ListAudio
    ///
    /// Parent Type: `Audio`
    struct ListAudio: SchemaAPI.SelectionSet {
      let __data: DataDict
      init(_dataDict: DataDict) { __data = _dataDict }

      static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Audio }
      static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .fragment(FileAttrs.self),
      ] }

      var id: String? { __data["Id"] }
      var name: String? { __data["Name"] }

      struct Fragments: FragmentContainer {
        let __data: DataDict
        init(_dataDict: DataDict) { __data = _dataDict }

        var fileAttrs: FileAttrs { _toFragment() }
      }

      init(
        id: String? = nil,
        name: String? = nil
      ) {
        self.init(_dataDict: DataDict(
          data: [
            "__typename": SchemaAPI.Objects.Audio.typename,
            "Id": id,
            "Name": name,
          ],
          fulfilledFragments: [
            ObjectIdentifier(ListAudioQuery.Data.ListAudio.self),
            ObjectIdentifier(FileAttrs.self)
          ]
        ))
      }
    }
  }
}
