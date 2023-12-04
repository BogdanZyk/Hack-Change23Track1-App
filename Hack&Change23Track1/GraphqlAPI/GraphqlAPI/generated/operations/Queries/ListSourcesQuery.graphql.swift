// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

class ListSourcesQuery: GraphQLQuery {
  static let operationName: String = "ListSources"
  static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query ListSources { ListSources { __typename ...SourceAttrs } }"#,
      fragments: [SourceAttrs.self]
    ))

  public init() {}

  struct Data: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.RootQueryType }
    static var __selections: [ApolloAPI.Selection] { [
      .field("ListSources", [ListSource?]?.self),
    ] }

    var listSources: [ListSource?]? { __data["ListSources"] }

    init(
      listSources: [ListSource?]? = nil
    ) {
      self.init(_dataDict: DataDict(
        data: [
          "__typename": SchemaAPI.Objects.RootQueryType.typename,
          "ListSources": listSources._fieldData,
        ],
        fulfilledFragments: [
          ObjectIdentifier(ListSourcesQuery.Data.self)
        ]
      ))
    }

    /// ListSource
    ///
    /// Parent Type: `Source`
    struct ListSource: SchemaAPI.SelectionSet {
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
            ObjectIdentifier(ListSourcesQuery.Data.ListSource.self),
            ObjectIdentifier(SourceAttrs.self)
          ]
        ))
      }
    }
  }
}
