// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct MediaInfoAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment MediaInfoAttrs on MediaInfo { __typename CurrentSeconds Source { __typename ...SourceAttrs } }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("CurrentSeconds", String?.self),
    .field("Source", Source?.self),
  ] }

  var currentSeconds: String? { __data["CurrentSeconds"] }
  var source: Source? { __data["Source"] }

  init(
    currentSeconds: String? = nil,
    source: Source? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.MediaInfo.typename,
        "CurrentSeconds": currentSeconds,
        "Source": source._fieldData,
      ],
      fulfilledFragments: [
        ObjectIdentifier(MediaInfoAttrs.self)
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
          ObjectIdentifier(MediaInfoAttrs.Source.self),
          ObjectIdentifier(SourceAttrs.self)
        ]
      ))
    }
  }
}
