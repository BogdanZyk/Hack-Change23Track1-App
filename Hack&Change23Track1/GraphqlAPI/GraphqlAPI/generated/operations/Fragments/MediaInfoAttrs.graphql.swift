// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

struct MediaInfoAttrs: SchemaAPI.SelectionSet, Fragment {
  static var fragmentDefinition: StaticString {
    #"fragment MediaInfoAttrs on MediaInfo { __typename CurrentTimeSeconds DurationSeconds Source { __typename ...SourceAttrs } }"#
  }

  let __data: DataDict
  init(_dataDict: DataDict) { __data = _dataDict }

  static var __parentType: ApolloAPI.ParentType { SchemaAPI.Objects.MediaInfo }
  static var __selections: [ApolloAPI.Selection] { [
    .field("__typename", String.self),
    .field("CurrentTimeSeconds", Double?.self),
    .field("DurationSeconds", Double?.self),
    .field("Source", Source?.self),
  ] }

  var currentTimeSeconds: Double? { __data["CurrentTimeSeconds"] }
  var durationSeconds: Double? { __data["DurationSeconds"] }
  var source: Source? { __data["Source"] }

  init(
    currentTimeSeconds: Double? = nil,
    durationSeconds: Double? = nil,
    source: Source? = nil
  ) {
    self.init(_dataDict: DataDict(
      data: [
        "__typename": SchemaAPI.Objects.MediaInfo.typename,
        "CurrentTimeSeconds": currentTimeSeconds,
        "DurationSeconds": durationSeconds,
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
          ObjectIdentifier(MediaInfoAttrs.Source.self),
          ObjectIdentifier(SourceAttrs.self)
        ]
      ))
    }
  }
}
