// @generated
// This file was automatically generated and should not be edited.

import ApolloAPI

public struct ReactionMessageInput: InputObject {
  public private(set) var __data: InputDict

  public init(_ data: InputDict) {
    __data = data
  }

  public init(
    from: GraphQLNullable<UserInput> = nil,
    reaction: GraphQLNullable<String> = nil
  ) {
    __data = InputDict([
      "From": from,
      "Reaction": reaction
    ])
  }

  public var from: GraphQLNullable<UserInput> {
    get { __data["From"] }
    set { __data["From"] = newValue }
  }

  public var reaction: GraphQLNullable<String> {
    get { __data["Reaction"] }
    set { __data["Reaction"] = newValue }
  }
}
