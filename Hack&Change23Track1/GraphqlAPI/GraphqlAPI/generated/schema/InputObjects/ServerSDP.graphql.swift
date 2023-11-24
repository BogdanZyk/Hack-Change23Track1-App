// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public extension SchemaAPI {
  struct ServerSDP: InputObject {
    public private(set) var __data: InputDict

    public init(_ data: InputDict) {
      __data = data
    }

    public init(
      type: GraphQLNullable<String> = nil,
      sdp: GraphQLNullable<String> = nil
    ) {
      __data = InputDict([
        "Type": type,
        "Sdp": sdp
      ])
    }

    public var type: GraphQLNullable<String> {
      get { __data["Type"] }
      set { __data["Type"] = newValue }
    }

    public var sdp: GraphQLNullable<String> {
      get { __data["Sdp"] }
      set { __data["Sdp"] = newValue }
    }
  }

}