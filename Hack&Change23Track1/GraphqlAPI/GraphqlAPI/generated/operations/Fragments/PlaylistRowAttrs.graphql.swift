// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct PlaylistRowAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment PlaylistRowAttrs on PlaylistRow { __typename Id Index Source { __typename ...SourceAttrs } }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.PlaylistRow }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("Id", String.self),
    .field("Index", Int.self),
    .field("Source", Source.self),
  ] }

  var id: String { __data["Id"] }
  var index: Int { __data["Index"] }
  var source: Source { __data["Source"] }

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
        ObjectIdentifier(PlaylistRowAttrs.self)
      ]
    ))
  }

  /// Source
  ///
  /// Parent Type: `Source`
  struct Source: SchemaAPI.SelectionSet {
    let __data: DataDict
    init(_dataDict: DataDict) { __data = _dataDict }

    static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.Source }
    static var __selections: [ApolloAPI.Selection] { [
      .field("__typename", String.self),
      .fragment(SourceAttrs.self),
    ] }

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
          ObjectIdentifier(PlaylistRowAttrs.Source.self),
          ObjectIdentifier(SourceAttrs.self)
        ]
      ))
    }
  }
}
